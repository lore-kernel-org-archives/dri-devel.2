Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39897F46C72
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 19:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A0010E292;
	Mon,  6 Apr 2026 19:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="m5z7cLFA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D343210E292
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 19:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMdIanbzpHHC8SmTMlEvkzUCg56JVarujZ8/1oHy+llzSQ5aSGqa+G33oEIXbxWlUsQt6iBlNVWsqHCo+aeC/rjyeb8Ge06CjKlI21gfRuKfK/VN5+kWhhZoNHxUZ7TgKKh97TWBpWFXsN5gVJ4ZL/79Tt7oXOl6TJHMgr4l1juNvmz4J+z/QfZ7ACnQTFxTRD4IwBqdX4w5/JetoKznPlYJ7lE/Rn6WEau9ENds3YGtoY9W3oEk+9u0X5P6ESOvgHlFQjH5t5vHwcuGzb3wvZKds0H49jtutuC44LApdM4lZ844UwOH8XpsdOTZ4O2fMFG8gmwAOpMkcIficCDCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr1zLl0VefzXUabzbpxbNKS3w3bdDGMEuvdj45DmHtA=;
 b=a/0335d/BWR3T1kNxlA24Vhc5v7KduYa30B1F9VbS+6GWoM4M17v+SEuX+8ynUCgGmzCF/PeSytDzZMDtlOSw6sDzF1tLu/YIuoBFcOteIhq4z5cf18JkI7FDw+6b4kG+C1S/9iz41NTOmxHnOd8xjNfi65Yj4AC92nhLkqhrtghsApt/U+wuKL1XLx6fj/PsCghKDyfqLT0cgGw98NGI16D54hY0WoyPZHeEPmvtPHUT1nACP5UIX84D+xVxtZXzBY0bkdxIkGsVfku4PbzbNRtIwBUy/Kfzrqt8H/wLuNoW6i45oqXHHiAJHC4lKpoXxysH0NlkyXJnN3wv9pCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr1zLl0VefzXUabzbpxbNKS3w3bdDGMEuvdj45DmHtA=;
 b=m5z7cLFAxpQLkfkDy220CeBRQrce2Idckb1qISqpKeD43GEKahfQvtPgLupQQyJy+V4EQmSRwpBT0WrbziITziJeytGuFNJYNaFsEZT6RWxrbfb7SEfwszOg9s0jhCr+C0rvc+o1rxzCZT8d93Edmr30gtGmUC90xb3RJAS/Xurnwu1DWSpr47ygigzLI4ffht5Ua70+S0E0SE0yMR4Jz1LXZDwxN93Wpod7QYcs4n754JSWgp3ZQHPT8oSh65LUgP05W+enVDD3EsImiYKx6F3KwHJNxtBglgdCfHP03/UpzN0TcqF++C4P+1v3ODXWFBrZxpWOwmXDCvekpFz0qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 19:02:27 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Mon, 6 Apr 2026
 19:02:26 +0000
Message-ID: <d9b51e82-54f8-4169-83e1-982f63d42ca1@nvidia.com>
Date: Mon, 6 Apr 2026 12:02:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] gpu: nova-core: gsp: add NvStatus enum for RM
 control errors
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-2-f3101093484e@nvidia.com>
 <f53185ed-5385-4335-af33-ceb347228176@nvidia.com>
 <DHM279KLUL8H.1IRPKG3CQCFJY@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DHM279KLUL8H.1IRPKG3CQCFJY@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc8f3da-1888-4929-536c-08de940f0b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 4R0agPSu+gUsnPv5Xv+A+fAC0yXnUUL46dbb90zpYIyCAzv2haOW/4fyNJ9V4/BAQl5hJbCgMQMC2g7dranxeR6sUC5XufJDsqxOajbupOG4CvzBifBIEYQYSdJ3NmmyMsVBS1izPMd7KJgMQueITlRf68u+U557MN+kuERWGZAvFOreNxcqtmqnc2mHj7n0x3WkDdGvICiJS7QeCFcXhHVEwytYL+5O4lF14TGFS0EJKOCDwFH71wW8wCqOD2A45ZRdOy3x+4xw2AYSsPzKISeBSp2bgdzFBq7mzhv9G7Vat3IGVWHelrbl+90DlQuQ2iHrz7ruAhCQOjFf/FKZbEMn+777D/ZAtsr0x3++DwyzeCvwH/BpiAavehGelUpHjqb2iqBndAGm7etbmTrQHX33GXVrWjQ54+/FIYKsTwZBJG7KlbdCooDChGlQL7UmZeF0y57hZDwtXL0oiBOLeNROVngSS7z9C0uemBbsLAWHMXGJz3/mueAVHBTIT4N+X5Axgw4IWwQ9SXvf9GDCFi/95zzSQ67dVkuBOiL+06teStRsvLENFYSB7BnEBH6Ql1wYjf3j7yo9ezZwP2ICw+bR8js9ySAFSlwHeLhBriLID6oR1MwYxNJDVSxYXbChUqT+qE8CH8tgfKSXCsPgbBWBIWtTIyZgutMRPecdRzBGP9GOZmhb8+I3ZEP8/Bo+RFkFRiFg0WQdlG16qFmVu0wCf//LnGNunFKvgWuNpMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME4xN2Fua1d1ajlwcGM1bUM4bk9ranMyZDlOaXgvUUljRlUxZmRoWVNXaXpF?=
 =?utf-8?B?bnE5azQ1YXcxUGNtZytnNUMzUlNxVEFYeFBZcmNJZGNERVZuR2ZyVno1SVBS?=
 =?utf-8?B?WDdvbG11YlpSN1pVcWYyS2lGeFNjOStaN0NZQnk3WEZ1S0FvKytSeEJreFJt?=
 =?utf-8?B?N3VGMGNlcUQ0MnVZMlFNWGgwSXV6dE9wS01lSlQ5bUNRRkQ0OHlndXdhekp3?=
 =?utf-8?B?ZjlYUm0xdDV3RkVSckpMNldjNzZTLzFUMkRKRkdZSWxmZTF1YjBlOWt3WkRi?=
 =?utf-8?B?alJraUdieWY4YnA3L0tqNStxd0dKa3pXSHdmUmk2aVo4RnlXVEVvbWxQMW56?=
 =?utf-8?B?d3gyTUZRRGpiNE1IY0N6UlpoRS9OQzZWcWtWSDhNQUlpYkg0TXZjRW9yai95?=
 =?utf-8?B?MUxiTlhjcHpad2krbS9HSGo4eVBCWHgzdlhjV0h1T29XTGxVbWxjOHFzei9I?=
 =?utf-8?B?c0Q3YmZiT2x0SE52U3BFVFh2Y21oRmlPM1BZbVFsbWE1ZEFtaXFGSDVhMjlk?=
 =?utf-8?B?c1lZb1IvRkFmSmVkVXRpY21vQzQ1K0dydDNkRlVlNDFEYlZSNGNHeFBPQjFO?=
 =?utf-8?B?MDZkcmVtSDFzN09IN05ZL1pCa2dUTllZNmpaQVVDVEt1ZWIrN1ptWXE4L25D?=
 =?utf-8?B?WTM2dGlPVnZ6VEl2d2wrSjcvSXhGZDZhdGhJcEZwTzlRRytLT3FPRDhHMFNq?=
 =?utf-8?B?YzNiK2N4UkplWEdlYVJpUWRVVGZSditrcmFQOWhvc29DTDRTaTFNdGNZR0I4?=
 =?utf-8?B?K3paYmpyQ25QRVlVQ3F5ZVlLN203dkI4V1pUZFhpQkw1aU5VUWQxTmdvbU9m?=
 =?utf-8?B?cDlPNy9SMHZUYVZ0aHUxTDdCazJPakliVmw0MlBnV3pGOHpCMnF4Rzl6SUYw?=
 =?utf-8?B?azZDbm01UGNocE1RZ01vaktlcWhLZURzYXZRdTVuNVMwV241VkdkUVZ3QnZ5?=
 =?utf-8?B?cVBMajNQbjkwQUU0MnhHSkNwdm8zNDVFbGl0QWRXOEtUUFJHeGhTMkxVUUVh?=
 =?utf-8?B?MGwySFYwWGplaXdWVm41WG0vd1dIWXdsRWtkRkNTNjRobkc0OGlLYk5OUmhq?=
 =?utf-8?B?UmRQVWN5OWVMK3FkLzZXS0p0WWw2cFkrcFRnV3JKL0dXK1A1bDZHZlBrS056?=
 =?utf-8?B?bTlTK2V4dlVPNnhyR2JSNklkSkdWME1rZFIrQWxYN1lQdGxnRVJvL0FxT2Jz?=
 =?utf-8?B?UHdPOHVQKzFzdDcxUW1udHdjYnVmaVk3NFU4NWFtSXVIRUEyb1VKQkkxa1Y2?=
 =?utf-8?B?V0o1bi9Bdk1peUxVSEpiQ0I0Q1ZOTVhPWCtKRVNla3VCTXFHYkZwZGRJU1ln?=
 =?utf-8?B?MUFtRHd0OEhzY29QWlFZU3ZlVDh5TUhNUnFEcVRrM2dUSTM0SHo5dGFtNUh0?=
 =?utf-8?B?ZmJCQzVQZjJRSnFPQUFOSEJEWFdIc3ZkOXJBd21scmpUNERpWkJlUWVaZ21C?=
 =?utf-8?B?aE5iWmE0OGU0TVNQY2RBUVJWOWRQNEVRRTBlRjFTbks2US8xUVlJcmNnd2VS?=
 =?utf-8?B?ZVJVNVkzbFF2ZDJMT2tUMmJHdXh2WDF3UzVMRDVTM1lNYWxndlpSNFdJUnNP?=
 =?utf-8?B?TWpReExCckc0cXl3K082K2wvR2ZmeVVOUmR2S1pnSkJWWWxyYjZiK0R2aHlk?=
 =?utf-8?B?Y2tzYnpLcEEzMUNvLzBXemMza21SeUZTRnQ5Yk5rbVhYTVVUalZsa2p4czRH?=
 =?utf-8?B?ZjczL0UrcU1Mb1ZTUmpyVlBZcjdmWVA5eWVwMzFZbkt4R0cwZCtmSFNsU2h3?=
 =?utf-8?B?Zy9uemY3NjRmbzEzTnN6SXhjc24yVzVIbWIybFQ4T0hid0tZcisxQ0s1cmZo?=
 =?utf-8?B?QTZ6cnd4VFU5dnZpbktRRkpqdmlMMUdmRDVicWlMczNnTjZrdWRxYmN5bGlS?=
 =?utf-8?B?YVhleWRMeHQzRGJ2d2NXMkdSMUM1R0JpR1QreGJUTkZPWXVIbEF2SThJWkpE?=
 =?utf-8?B?TXY2UFY4TVptNDFrSjlvV1cveTYvTGdDWnI1Z0lwVFhzbXlkZjVSVHl2MjlI?=
 =?utf-8?B?TUFveFZMdENWQkhJNGZ6cFZrdFJzNjUzTUFKM1o3ZExDaGlJaG5xeHo5YzdL?=
 =?utf-8?B?YTA1Q05EUS9BUnBQOWNLNXNQcTlIZnZGSGJFcjVWRmN6NjdXZWhleWRDZ1Nq?=
 =?utf-8?B?THlHRkZRTGg4UWZpTjJzMWJLT0lMaytrQkw2MHA4cm1TcStWT2E3V2NVOXkz?=
 =?utf-8?B?cGxMRFFDNUhFNUN5UEoyeHdtRHNNWHorNDA5c1JFbVR4YUFYdHBkdWUyVnU3?=
 =?utf-8?B?V1Rqdm1YL1pKUDZVbnRKUjNrK3pJMHFoVmFrOWFIUmo4TmZPRldna0E5V1pO?=
 =?utf-8?B?bXFSV1VucDNkVFJjVDAwOEg0bDcvQ0ltMFYwVnZscnp5OFBsekZ3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc8f3da-1888-4929-536c-08de940f0b2e
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 19:02:26.8039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwmZ8qNer5avKXkdMvMT02DUfuDBRufCN/lV1H4n/toID2KmivlKYg//FPS/57HCcqxdOBf01qHrzYjrF0immQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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

On 4/6/26 5:09 AM, Eliot Courtney wrote:
> On Mon Apr 6, 2026 at 5:05 AM JST, John Hubbard wrote:
>> On 3/25/26 5:13 AM, Eliot Courtney wrote:
...
>>> +impl From<NvStatus> for Result {
>>> +    fn from(status: NvStatus) -> Self {
>>
>> This discards the NvStatus variant. The caller sees only a kernel errno.
>> We need to retain the rich RM error codes for debugging. For example,
>> a caller that gets Err(ENODEV) cannot tell whether RM returned
>> CardNotPresent, InvalidDevice, FabricManagerNotPresent, or
>> ReductionManagerNotAvailable. Something like:
>>
>>      fn send(self, ...) -> Result<T::Reply, NvStatus>
>>
>> would let the caller log or match on the original status, and convert
>> to errno only when propagating upward.
> 
> SGTM, let me push NvStatus handling a bit up the caller chain then.
> I was thinking it might be nice to not carry the openrm naming, and
> instead call it e.g. GspMsgRmStatus.

Yes.

> 
> But, I don't think we should use it as is as the error variant of
> Result, because it contains 'Ok'. A better shape might be:
> 
> GspMsgRmStatus {Ok, Warning(GspMsgRmWarning), Error(GspMsgRmError)}
> 
> Another issue is that RmControl::send needs to also propagate the
> kernel::error::Error from calling the cmdq. So we would need a wrapping
> enum, e.g. enum GspRpcError {Transport(Error), Rm(GspMsgRmError)}. The
> (currently unchecked) rpc_result field that comes back from GSP messages
> can contain NV_STATUS values (as well as some other ones), so
> probably Cmdq should be returning this too.
> 
> So if we are fine to just log warnings instead of surfacing them to the
> caller, we could do:

I think we are fine to "at most" log the warnings. (RM is too verbose
in many cases, so I'm hesitant to categorically log anything at all.
Case-by-case evaluation is probably called for there.)

> 
> fn send(...) -> Result<T::Reply, GspRpcError>
> 
> WDYT?

That all sounds good.

> 
> If we go this direction, I might create another patch series for
> defining GspRpcError and adding support to Cmdq for returning that,
> based on the RPC header's `rpc_result`, since we need to pass that
> through here for RM control.
> 
>>
>>> +        match status {
>>> +            NvStatus::Ok => Ok(()),
>> ...
>>> +
>>> +            NvStatus::Timeout => Err(ETIMEDOUT),
>>> +
>>> +            _ => Err(EIO),
>>
>> This will cause failures for NV_WARN_* items, which is a problem.
>> RM warnings should not be converted into errors.
> 
> Do you reckon we will want to do anything other than just log the
> warning?

Tentatively, no, I don't see a need to return warnings to the caller,
unless we notice a warning that is somehow actionable (I don't recall
ever seeing such a thing, though, and it seems wrong anyway).

If we decide to send warnings back up the stack, that doesn't seem
like a big change to nova in the future anyway.

thanks,
-- 
John Hubbard

