Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0271EF4ED4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 12:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E4B889BE;
	Mon,  6 Apr 2026 12:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="duP6CuGj";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE49A889BE
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 12:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgI9V2AH6apWLxsKS0RVRYBXqpubtWdmxocEqw+ldGh5HmOG6Dj/QVQIuPpnmuWvA6rF0GO1xUPGthDMP4fs79wv2aRS4DYdYfh5ePMrQwww3dFpBlv8Mng6rBMwMhDorkX7FrIU2ptijs8hngeDvxP6d2K4e0m2NBH8S+9rUIbYwT9sq4FtgbjHQHzwYp1IpNVdRxyRLLvHMhUsRb/o15RC/NdGR+lyCKDBG6IJjcD6oDj61HmZULhTzCueNoZOwpGVQ6ECxITZbseoEAUELbDr+v5Pgj1B+NVDV4oKm/GInnpqmvgnMRCfXNUR60epNLTSBrsoRjKQrcIAkzez2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5Lv0l/2OLcPIJZhEMN39fzk7sNxRFbQWB6lDDBBeGY=;
 b=HCnKeMWCREuEyddT3KGy1NlqVT5nBZYkwSSO8M/HCsDScKxewXTqxLWnPqwNbmkTQvkntBf5n1O9AvE7u/UFXsd3aa68iPlWh7TFvgal31nFLZ/lXH0WVbwA9tJT2N5XXm+//FLxURuUCejhkSwZM3e3FT9fjhkHU5WuzLPJmacODPz7nLMjFwW/Smviinct36iq20UuRtTxFrSIR8JnE6SP6tNqsDUY9oTwM5+HcvTOvTigsuJJca6riXTc1E3qQhrOv0tnZYd2RkfBoO0Y0ZzaZVSYOmBwkYEdzthGWGOPinkb5yOUF3BCEih8gLOXvBLbfKn4vXOmTb7Lcsx3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5Lv0l/2OLcPIJZhEMN39fzk7sNxRFbQWB6lDDBBeGY=;
 b=duP6CuGjN8bmGxClQf/27KvZ/bPY4zO1uoKgD6k4ligK8MkSnoeqkPU7b01PSurCUB8mTH9bP0Tv2Gb3BsjT+aW4x9vgQVz3tzgR8wzJVAqbZNSgdoNzSM3XXcLBD1IYIQtnoCUowWcrRoxyeL/MphJcKXtBZ1I9nQ4FQ7ywUkKZlA4cHqyMfyr/JuNH+8oMO8sMS31yxf+5G8V/wbzksQljZ53A4Kzx/43cGDZOIUF3QdNluPlEGclv5/YrGeBhCWsZiYGgOPpDfO6YaLs27UUKbU/L1C1k6q58pYIUlHFc/TwsP7o/1cdGVkFV/E3q2WeTDkSxQrTa87Jv/cDTpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 12:09:40 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:09:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 21:09:34 +0900
Message-Id: <DHM279KLUL8H.1IRPKG3CQCFJY@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] gpu: nova-core: gsp: add NvStatus enum for RM
 control errors
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-2-f3101093484e@nvidia.com>
 <f53185ed-5385-4335-af33-ceb347228176@nvidia.com>
In-Reply-To: <f53185ed-5385-4335-af33-ceb347228176@nvidia.com>
X-ClientProxiedBy: DU7P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::32) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa1c28f-39c0-4376-f11f-08de93d56102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uYKYNTyAgjOb7+yqVGy47xzeOO+sebgzwgAIlzP1taMNb9IjDNxn3oULVm8ZgVKQdAsIarOJDkY7Qa7J3PirxlQUc0RoiRiRMmb2ZY3rv1EYrb1m+RpmN41vxkEVrnTRGqvmKbHy2Vv/OkqENSoOzKS7a6lqSEATrQGqzFCw+pi/vikqceG09WfZYxfURqAfzlcYvRDGYquF7H0vsmVg9Ldxz+3u/dbHKzR0aoB83WSfuMsVTFXC7qRS3YfIFe9DFWXVtAbgnLjxKExn+ExORzJpLz0SYNbiy+Ht5wBUFrIldDZ4vx66pIfTqFNgbGTVnrTIhFlPMmAKiPP4t2N0j35hnfsViz+Id/iy8Vs1Scqe+OUYZ7lXt+B4UvUmITS55At4PPxzfXbNkLf42Kk9Gnb4GJKyK/TgdDr0C16IAZOZOdJITt4OjzHroFt+qqYdVNVIg0aOp5O+szENk/TOBSIntdUYV1gnrqV3NHQxMDVSTnlWuJouY1Qg1/EHTe+AjmxCm0VinyBmMq8TpMSZVp1+hAzp+YDd083jR9Mn/ZNAHf5zgEwhcYrOhg4M2aZIl2pFa/sd6Ar7Z5JkQc/Sps8z7ANcnVk7Pv2mTxwehDkhCKHn8wyO7j2z9uc+an/RJrFVNiUSEsA8pXimAZI5jIIfDNGzkLOQxdYHZ2hAAz6uCxjoUzhQmAK+BqD2S8CeL8OR9UMyc73oDKZV8AhC2iWxj8p/ESceejbBWRXSKrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXlnL1VLcVJUSmQ2eGZFdkxYanJkUWtnMjljR2ViRXJDMDBUY2JmV2NGM1ox?=
 =?utf-8?B?MTRaYXhaYzNVcU1ncmVBaVFybldrOFp6bVA4dElaenFvTUIzNEpNL2k4cDFY?=
 =?utf-8?B?WVJRMmlYeG40VUd3Vm9LYldWdWlpOEk5bU11OU8vQnJzODczNGZtaitPNkNW?=
 =?utf-8?B?NUR3SVUxUzdLYjhiMER3SWtUUXpiTll0b3BrY09Nd1RMNFNRUnAvL2FSMlp1?=
 =?utf-8?B?WEN0UzFCK3dCM3FIVkF6QVF1TWEwV1JFMG95eEgreFIwb2tuQmg1c3VGYVpo?=
 =?utf-8?B?N2FQUTZLT3lHNmdQWHBHV0Y4VStPNExsOXRKUzBjejhOSnhFZUoxUmpjVU0v?=
 =?utf-8?B?aTNjejllUC9KcmRNbEpGVWdOeUY3MmRLbk1UQjd1ZGtYVWxsTmRKUVlld0kx?=
 =?utf-8?B?SWJZQkZiRWlsVDlaMWVJSmJDQnFPanlaemVZRVN1NFBzbVlZaUMwQW5HUjZ1?=
 =?utf-8?B?TGtaK3pMK3hCcU9sajEyOHNVUmxzQVZ0cFZRV01YcVFUajZtSkZTY3FCeTVE?=
 =?utf-8?B?enBYTmdEblJNbFJnbGw1TTFqQStORFZWeHZBYjZtQ1FFQTNocUVEZGZYWnBx?=
 =?utf-8?B?N0ZNYXBRcDlxdjVqTkNjcmkveEs5Z3c5M3ByUGswZFdLWWpBUERVeEZsNlJv?=
 =?utf-8?B?NHM2WXRud2l4L1BCemFpYjdhUDFhUFB6OFlCTml2dmpqVXBCUEtjUXFIbnZS?=
 =?utf-8?B?SU5RSlVjcDBpSUtkd0IzR05jVDJBOS8xTmZpeDErajlCN0srZzM0amxkZDFT?=
 =?utf-8?B?WHZnUjVZTFZxcjE3SWR3WFpRZnpWdXh1azZFZWtQTWpwMEN0VXhZZnJMbU80?=
 =?utf-8?B?U2YyOG83ZFJ3enBzY24zeTJ3Mm9sS1FRRk1saVJqTEp1U2pTV1cwWGV1NFdJ?=
 =?utf-8?B?RTVEVm1MODRHdC9rZmtxNVNHYithckZiUnNZZFNpK0ZQcnRvZHRsRmVuMWxM?=
 =?utf-8?B?QUV1ZTFNSzJWcDViU2pjWjdNNFhJYjMzR25iSjk0Q3ZIcW5iQkpmdTZTd21B?=
 =?utf-8?B?eVpuWXNTWldzOVNpbDdqbjgwZ1V2V3hmcGxOYWNSK0JsV1Rrdm1FZlFFcWZK?=
 =?utf-8?B?emNveGdqYlA4M1Z0alFoYkxFdTIrZWl1TkZHc2Fudmw3Z0VrYUYxZmdHVEk1?=
 =?utf-8?B?dGh6b3I0RGgyejdoNG1CREp6N2F3UmU3Mm1HSkZrbE8vVnM4S0dObEhGVnds?=
 =?utf-8?B?MVpRNGlqZmlKbGhJaW9xcWhOVHIwNGNnS05BRFJDbS93dWtFeUVmWmd6dHZQ?=
 =?utf-8?B?dlk2WEp3WSs1cGVJVGJDSEZTNDdVcmJ0YWxqVmRrZlplZnlQL0NyQmQ5ZHVs?=
 =?utf-8?B?Y2Z0T3JTTC9UanZ3Z0lTRU1OcGxFaW93Z09ocVRMdWQvWTI5eFBsWUlRWFBn?=
 =?utf-8?B?TDZyRlVLbzRYSTlNUEc4Rm5oNGdFSEVZbVZaZVNRb0VoSXFldnJuTHlOc3Vv?=
 =?utf-8?B?dDE4UEl0Yi8zSiszQ3dlenRwVlBBOTRIcGczWGZPUzlLMkt5TkdSdkMzZCsr?=
 =?utf-8?B?cUh2Z0RBeEk3b1NmWlIrNXdBb2xqSGY3OSt0ZXpSU1p1RGwreWpoME1wYVNn?=
 =?utf-8?B?QlplZndBUFlyQktlcjhpaW13cE1FMjB3Q1RPYjl6akxlaW04SEhYK3UxQXlk?=
 =?utf-8?B?QzFSS3pqbXVvdjdkSVZ4UTF6KzFJUlhuMU5uaFFQbnhlSHJSelRROEhZWG8y?=
 =?utf-8?B?NGVLWG5SdE9NeGp5TjllTXBoMmR3T0o1ZDBwNGluWXkrZElDWkNQQjluN3Ix?=
 =?utf-8?B?MUJvVEJnbm5SK0xWZEtZcXlGN1VUU2MwUVkwYlNKRUxRbGtjL2VtS3ExL3pT?=
 =?utf-8?B?RzJ4ZW9obDNPWTZDeUFodm0xVkF1T0E3dW8wTWNVU2FRTUdnWm9QNGNyclJv?=
 =?utf-8?B?dUxxeW90THVIT2JVamtXVHU4anY1dmQrSXdNOUpwdmh2NjMxdlRlclBoeGhm?=
 =?utf-8?B?M2p5NnBQSTI0YWtDUDV0L3VCZHRjbExVZGpFOVVSQkFxS0t0K282Y28rT1Ix?=
 =?utf-8?B?Ris4bThqSU1FUjhPT0Ryc2dIUUxlM2s5SjRpRXJwZTRaQUdZcXZmV2trU1VP?=
 =?utf-8?B?djBNMkt2VStpRUFpRFNOejhzZ2VpMlR3dDViRTJWQXEvdEhyRTE0RWxsR1Vv?=
 =?utf-8?B?RmpoQllXR25taWlZVzBJVzR2NitBNlp6QmZpeDUyS1dDUDNRNm5VUjVleE0w?=
 =?utf-8?B?MHdQeGhQR2R3MjZVSjFTZWxvRE9LQVJaMnlvTzZUMDhnRGdzSGZRa1kwb0c0?=
 =?utf-8?B?MmJicnFIWVBHQ3I3UjlJeEdEanZBTTExNHBKKzlDZDMxWXo3d1NkUmxZNFo5?=
 =?utf-8?B?ODRaa3R0bkVjd1ZtZGU5RzIyRXRGMEhBdXpWaFNPbmtOSHFHdzhBVFEwckdL?=
 =?utf-8?Q?vsvRTCjsXjDQdta38UO0a0FXi8efLsY/d7RwtilBIOYYu?=
X-MS-Exchange-AntiSpam-MessageData-1: 75PcG/S5mOxx6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1c28f-39c0-4376-f11f-08de93d56102
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:09:39.9260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eugtw4OvJSBJ++ChveTdn9BYMppR1fbwgvMB+aue8pOxfDWzeckEIalRJfeI1fdx9br0Ev7lgfhKElPnslF6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon Apr 6, 2026 at 5:05 AM JST, John Hubbard wrote:
> On 3/25/26 5:13 AM, Eliot Courtney wrote:
>> Add NvStatus enum that wraps the raw NV_STATUS u32 codes returned by RM
>> control RPCs.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>   drivers/gpu/nova-core/gsp/fw.rs | 401 ++++++++++++++++++++++++++++++++=
++++++++
>>   1 file changed, 401 insertions(+)
>>=20
>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp=
/fw.rs
>> index 0c8a74f0e8ac..cb4bda253193 100644
>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>> @@ -97,6 +97,407 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coh=
erent<GspMem>, count: u32) {
>>   pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =3D
>>       num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
>>  =20
>> +/// Status code returned by GSP-RM RPCs.
>> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
>> +pub(crate) enum NvStatus {
>> +    Ok,
>
> As mentioned in my respose to patch 1, these are hand-written and won't
> automatically pick up anything new from bindgen(1).
>
> If for some reason we don't go directly to generating Rust bindings from
> GSP-RM builds, then we could somewhat mitigate the problem with a
> declarative macro that generates the enum, the From<u32> impl, and the
> From<NvStatus> for Result impl from a single table.
>
> That would at least prevent internal drift between the three, but it
> still would not detect new binding constants.
>
> It would also add yet another macro, sigh.

Yeah I feel we have a lot of macros. But, at least for From<u32> we can
use FromPrimitive once that is ready (see my other email, maybe better
for me to switch it to TryFrom and get rid of Unknown). As for the
mapping, we have to think about it manually somewhere, so either it's
here in a From<> impl, or it's in the bindings generator or upstream of
that.

>
>> +    AlreadySignalled,
>> +    BrokenFb,
> ...
>> +    Unknown(u32),
>> +}
>> +
>> +impl From<NvStatus> for Result {
>> +    fn from(status: NvStatus) -> Self {
>
> This discards the NvStatus variant. The caller sees only a kernel errno.
> We need to retain the rich RM error codes for debugging. For example,
> a caller that gets Err(ENODEV) cannot tell whether RM returned
> CardNotPresent, InvalidDevice, FabricManagerNotPresent, or
> ReductionManagerNotAvailable. Something like:
>
>      fn send(self, ...) -> Result<T::Reply, NvStatus>
>
> would let the caller log or match on the original status, and convert
> to errno only when propagating upward.

SGTM, let me push NvStatus handling a bit up the caller chain then.
I was thinking it might be nice to not carry the openrm naming, and
instead call it e.g. GspMsgRmStatus.

But, I don't think we should use it as is as the error variant of
Result, because it contains 'Ok'. A better shape might be:

GspMsgRmStatus {Ok, Warning(GspMsgRmWarning), Error(GspMsgRmError)}

Another issue is that RmControl::send needs to also propagate the
kernel::error::Error from calling the cmdq. So we would need a wrapping
enum, e.g. enum GspRpcError {Transport(Error), Rm(GspMsgRmError)}. The
(currently unchecked) rpc_result field that comes back from GSP messages
can contain NV_STATUS values (as well as some other ones), so
probably Cmdq should be returning this too.

So if we are fine to just log warnings instead of surfacing them to the
caller, we could do:

fn send(...) -> Result<T::Reply, GspRpcError>

WDYT?

If we go this direction, I might create another patch series for
defining GspRpcError and adding support to Cmdq for returning that,
based on the RPC header's `rpc_result`, since we need to pass that
through here for RM control.

>
>> +        match status {
>> +            NvStatus::Ok =3D> Ok(()),
> ...
>> +
>> +            NvStatus::Timeout =3D> Err(ETIMEDOUT),
>> +
>> +            _ =3D> Err(EIO),
>
> This will cause failures for NV_WARN_* items, which is a problem.
> RM warnings should not be converted into errors.

Do you reckon we will want to do anything other than just log the
warning?

>
> thanks,

