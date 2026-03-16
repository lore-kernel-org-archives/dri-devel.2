Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4B0F46455
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D8D10E4F4;
	Mon, 16 Mar 2026 12:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QLzDvrSn";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF5A10E4F4;
 Mon, 16 Mar 2026 12:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXL0Kfdaw/tBuwXNa4Pd672W55nP1AzHL/nN2p7zjztuvsAcJdFsl9Alp5JhA2tvK0gdzbZatu/iHcX0C4Y8EGsH30pfD7dB4L8eg+pW8dKO2Bj6vOoQlWoFqDdeCl7UOWrqfmWBgaTgoGdfxs5UL+QWaaIywkjkwZLXb7HFRzPKo6ACYHPXj71hgucGF9NuX4QqmYdJnAH0SIV4dZ+a1+oltgw4dI3SjG/rh/c0GwELk75iiPtQsIG0TMNim2Qu1+T5W7gQEqk4aAB/GF3e1pLl7VddSdsL9OEgwflZjLjEypwX1Ns8AvZt/cu6dEShYj8GizOd0i2trkqmjeyWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU5gyKEBOgsetWIn3RGKRVSLNhdsQuHH2LLDNJd0of4=;
 b=y4WHRqrpHqXCIFnMmBBGk2uraEosKPhPudmzmOI7ZqAz3XY6QuscptgM62s2sb0IDtoZLFfJMK8NU6HGBcB3XWY1urTPw90On7IyZgQbgiwOU0rctWt+e9MOscoKMMVIxK/gz8ik4f48bEcrcUEuWOrgNQtK35ET0RLeShb7QFagXgXdTd1fG2prWF03hZ7QaX0zileoKXrls49lHiYT3eRw0vbS1p+rkPPj1dtKbmQctsWHyp4Uw5JnLmHU7T3sPpN91Y8dHhQsuji1PL/pPI7n69vS+epCe8jDxNwqVmWvDhoBUTNoPBNtBTUPJS8Jyw5M5huF+ATb99z5RRCUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU5gyKEBOgsetWIn3RGKRVSLNhdsQuHH2LLDNJd0of4=;
 b=QLzDvrSnkL8PxmqBH4vlqfXA9V8MLZ7WtX1k/YF5J5UUSq+tVOw+SMZA1gyfup7oRhe/4BuTKa6MCx9XLTevnNIll/5MbNep7k27bHl4E5CDQvfR57ig6wtU5INA9RHrEEAkHFohZahSWmts43Z1wU3VyAwUiz4zYP/+yoFnsVkPqmuuS276BKsEmeJ8YKRbQmjty0wbt0DreViEryMlpDTEyLT0RJqivUD5nFZdAoTDnMNW8P0HVXYtHe5CjyBlB3MAHb2RPpjF0T0Mn3dkjij9G2NH7iKgF7LG7zzU/9cnidCYfD/XomfEnx4aLeroHkmRmWg76ayszFgmoIrSfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by CY3PR12MB9655.namprd12.prod.outlook.com (2603:10b6:930:100::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 12:06:34 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 12:06:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 21:06:31 +0900
Message-Id: <DH46ZI0CRRKZ.1UZTS1TIWPRTQ@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] gpu: nova-core: gsp: add RM control command
 infrastructure
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-7-86648e4869f9@nvidia.com>
 <DH1RNJQP1IK7.1H96Z7TENYPC@kernel.org>
In-Reply-To: <DH1RNJQP1IK7.1H96Z7TENYPC@kernel.org>
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|CY3PR12MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: 2699bacb-bf1d-4370-ec5b-08de835477a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 87iAYMFIGvJlK5keg0q0D7p1Jq5yjBm8TEnVvnf8tNl6rD+07BXAATHqGbHvtY1nNAd8+z3oqG/0+ccjYOHO+rkATALgkj3H2lFCKH/q9oQO+TmpCmQdAJSm5XHqwzwPr6PPaAoVRreAbkZHflzM8s6Jm0xfJsVObDgFiETMirGhaOz5ExaqQ8/H8L9aQRylWUfn+icx8ys86l05hepU35JHMx2GKQ1BZeGTvIID1fd5kvxSD+0HI7Hi5ZjHw0Rakn2GJ4rR/8KoNCDppC+0T30YtdKAPpOmbRbNJ8TxmXEoTJZQwHGXZzbj9GV1mseYtjbycbljlfV5AuZFu5NIphtuPHYLWLpFvKfxTNT/snIJMgRIMKM/VYNrDeWSy097Ybi/07ExsPIY6A6g3vQa6TlQMruv9gboUtYg8Yz1vCUY0EKhQEZuSHGpI9bVgYFraIiyFbpSld7P4CrB/Hh1KvQ5nUGptzpwHi9l8skcOxcKpvYL+40n2lTFEyIF0r3oQ8MIc/0ldzLAexFW6zRLKV6Ngg2xhyss1ILD0bmxcVNzHOeC89jWvtHrXCVTtDAOeKW14YEb7S4oio5fLqMrJ7ZkPDz07mwMM1kyg0SX//qGqC8Xg+T026muOrLxJprvyL/XIVlV7IsUbQqgDkQv3OzmUSkD5gZ3o5ElIZr9VTWqYYyWEKguOb9tUn2J1SCZo3feSi+q74L5vuV14Uf7sC5nfaqMpkZG5v+6uuBT2fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJhbmF3UC9tdDMwaWNyT3ZJVytPUVRqUHdrQkNKaS9jeWhEZDZFWTducUh1?=
 =?utf-8?B?VFJRYzRjQ2MrQ0NwNGNKWkNsck9DcDlqYklsNUIycXJ5OUMxdkdPdjY3OGN1?=
 =?utf-8?B?dWVFb3BReS9wS0g5cDFSUVlodnREMnlTeDRZWXZnZEZYSGhteXhIY3RFSXZk?=
 =?utf-8?B?d3M3cWVJMzloNGV4VlBnNU5JNEtUNU5CUHpJUjRqbXd6Z0pwN3dIa1pXdnZ6?=
 =?utf-8?B?Nk1XSDRoWThUbE1oUHNrK3N1VkFZazdkWHpEVVhHeVZ4OTY0YjhXTVZjTU95?=
 =?utf-8?B?U1FQL2I0Q3loRmVRQzUyVHdqSENieXYrZFEwMHc1WENEWlRMRGNkdUVYYkVN?=
 =?utf-8?B?TVB0ekRSWTloQUZ5L3JkVVk5Q2cvRGt3NFNZTkdxcXhIcDdDejF5ZTRMZHUz?=
 =?utf-8?B?U3c2WUx2YitORUFaOW1iamZJWXVSaXozLzNyRTRzSVhTQVJwR3lFQWN3RWg0?=
 =?utf-8?B?UjNndC9sMklOVTJHR3Z0N2Y4OXl6Tkt5c2FRampxcm9kbkxvUWtJdlZFNXZ4?=
 =?utf-8?B?N0dDOHl0YXhxdnc5UkorTnI3dlpqcXFZcXhpUS9UVGFuSG9QRXQwUm93Vk9E?=
 =?utf-8?B?bWJnVHBjaGx3Vk9wR1NrVEFEa0poeGtpMmgrZHFjWUF5SHJnblN2Yi9JYkt1?=
 =?utf-8?B?OWl3cjhHNzJIY2lGZVhlRkVPcDc1azVlQ0lOWDNXVjlFZ2hrLzZ6a2pEZEJI?=
 =?utf-8?B?WlkxeTBJMjhsZ0NDWndwN29Sc1A4a3RMVHRiZkxGMitsVTM3NzcxS0g5Zkh4?=
 =?utf-8?B?ZHNSMEdlTHhDZDVMSWVHczNsWXJMTnBoL3NPVy81WitleTF2dkx3UmhHdENQ?=
 =?utf-8?B?UWpxNlFSem9KdmRTaUZyalBXZktqdWM5SWNHWHBBMUNWNHJzQkYwWjdWbm5N?=
 =?utf-8?B?MUk5RldyMTdrUXBNeitzN2hRSGpDOUNiT2ZWM3ByTGZLQ0M3Q0UraWdnV2Fp?=
 =?utf-8?B?WTh6VmRlbG1RTWh3SHdSV0w4NENoRldrWkN2aWZlUTdhekZEbHlRYmpBUnhx?=
 =?utf-8?B?Si9veW1lNTI5TEZnMlZ1VGFnUS8vYlBxZFFUdWRHaTRraElRcnY3c0l6TlBW?=
 =?utf-8?B?RlhQcURjeTFsdTQ4T2hNMWJpNlNET1VoMnBiUVJrT29xMG13VGJ5MGtKdnlI?=
 =?utf-8?B?eW9JZ3BWL3N4VnVldmFYcUJYNmc4Y1pPSnQyVlZONTVObjlFd3ZxTmZkMjVN?=
 =?utf-8?B?UVlTTmp1Rko4c09WSjlhajk0cGovNkJDbFU0ZC8wSHo2UmVjb0VwcGNLd1Ba?=
 =?utf-8?B?TUFneXJGdjdUZDVJYm1yUWNBNUdoRUQySGdvMFM1MnB0MUpHSmIxUW5JSWFI?=
 =?utf-8?B?ZzJwTFpmZ21hV0JlcFVmTStkN2szTGF1SCs1OFJjZXdqL211SVZ3c05qdVcx?=
 =?utf-8?B?UDVEZU9YUVJrS1dZdU5kTHhhNGxBOXNaR2J1c0pCQStobEdHUjRXRDNOOW1T?=
 =?utf-8?B?TjUyWTAzZUdFM05aZC8rTWs3TG1ZMDJ3VlkvbVk3eksxVWtYd0FRMWRCaXVk?=
 =?utf-8?B?OXhMRXdiV1RJMHdXM0xoWUw2M0g3bEFEaU9FS3NyNXBRcE5IRWZTSzBvRHVT?=
 =?utf-8?B?bVJ2bjN0UmRxTjlqVFBxR3M1ZTlFaDhKZ2JpUVluZlhsSlFmei9rUHJ6eWZM?=
 =?utf-8?B?d2cyazlUQWFVajJ2QzRnTzBhdngwNDUwUkg4TDd6Skx6Q1BOeUhDcm9WZTJq?=
 =?utf-8?B?dGFnQkN5dHBVU3R2bXhQRURYVDRVNktKYUZvK2txeC9XUzJWMW42VndKQ204?=
 =?utf-8?B?ZTB5aWQ5OFowUHdlZGJReitSWll0dWxuRkJPeGVKYXJhZUR1MjhpTEozM05s?=
 =?utf-8?B?MnlUVFJpc0R0S2hNcDB3MkdQY1o3TDFRSWpuOXRJbTdJaW1QNGF3Rk94bWNR?=
 =?utf-8?B?Q0FSOUt4MTcyU0ZqRVoxU0FvaVdOVVc5Wms3VkRpSVNpdjd1cklib3RMaThM?=
 =?utf-8?B?dFplK3hzM1Q3eW9IUkNCeUJXR09tcDRSMVZRL0tOYzNnbURObUVDOStCcEZS?=
 =?utf-8?B?bGV5RW9TU3FNTFNsT24wTmloRGcxQ3BKRUhOZjZkUGpVcGFWTXFRbUlseWVn?=
 =?utf-8?B?eHVlT21yQjNyZGlBOEV4c3dOMHlTWXhDVnBIRlNNT0VQOWlTMkYra2I2UzEy?=
 =?utf-8?B?ZURla3RxL2owQUdEZnV6OEVxUExuZTZHUlA0dWR1RGhCclpKcWdzdU01R1NR?=
 =?utf-8?B?U2NDdEY3MUE3YW1xZlpTb3ZTSjY1c3VudlZLQTg0NWo2YS85Y0o3aWw2Q0VB?=
 =?utf-8?B?T0ZVMzQ1YkFKUGdNNkNyWkc4a0FwNXdFYWh4VlFrZE5zK3hKQmFKLzUxN3JT?=
 =?utf-8?B?dU9KOHFVcUdWSVVYYzJpZ0R3eHpZSmNkUk1KazR6bGZ3NEVySTlsR1VjZkU0?=
 =?utf-8?Q?Mpt7oF3jSR0ej47pLgthwPgXzZwIrRDG5PQq0p3mO8faf?=
X-MS-Exchange-AntiSpam-MessageData-1: lJ5AFk/LqoSwtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2699bacb-bf1d-4370-ec5b-08de835477a8
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:06:34.4880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5lXyEIJES/lqUziH5zgqZmxTcsPCTCbPxvm36Ck8Li83kEB/lFVIt6hOSEsdB7QHXEWSzClQstCIaRstFd7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9655
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

On Sat Mar 14, 2026 at 12:40 AM JST, Danilo Krummrich wrote:
> On Fri Feb 27, 2026 at 1:32 PM CET, Eliot Courtney wrote:
>> +/// Command for sending an RM control message to the GSP.
>> +struct RmControl<'a> {
>> +    h_client: u32,
>> +    h_object: u32,
>> +    cmd: RmControlMsgFunction,
>> +    params: &'a [u8],
>> +}
>
> Please expand the documentation, especially the fields.

Will do. Will add an explanation of client/device/subdevice/object
plus fix all the names.

>> +/// Response from an RM control message.
>> +pub(crate) struct RmControlReply {
>> +    status: NvStatus,
>> +    params: KVVec<u8>,
>> +}
>> +
>> +impl MessageFromGsp for RmControlReply {
>> +    const FUNCTION: MsgFunction =3D MsgFunction::GspRmControl;
>> +    type Message =3D GspRmControl;
>> +    type InitError =3D Error;
>> +
>> +    fn read(
>> +        msg: &Self::Message,
>> +        sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
>> +    ) -> Result<Self, Self::InitError> {
>> +        Ok(RmControlReply {
>> +            status: msg.status(),
>> +            params: sbuffer.flush_into_kvvec(GFP_KERNEL)?,
>> +        })
>> +    }
>> +}
>> +
>> +/// Sends an RM control command, checks the reply status, and returns t=
he raw parameter bytes.
>> +#[expect(dead_code)]
>> +fn send_rm_control(
>
> Why isn't this a method of Cmdq?

Because this can be fully implemented in terms of existing primitives
available on Cmdq - it doesn't need to know anything about Cmdq
internals (it's a protocol on top of the Cmdq, not at the same level
of abstraction), and it fits the existing pattern of adding helpers for
sending messages to/from GSP (e.g. `get_gsp_info`), so IMO it is nicer
to keep it out of Cmdq.

>
>> +    cmdq: &Cmdq,
>> +    bar: &Bar0,
>> +    h_client: u32,
>> +    h_object: u32,
>> +    cmd: RmControlMsgFunction,
>> +    params: &[u8],
>> +) -> Result<KVVec<u8>> {
>> +    let reply =3D cmdq.send_sync_command(bar, RmControl::new(h_client, =
h_object, cmd, params))?;
>
> Why not let the caller construct RmControl?

Yeah, that seems fine to me, as long as we don't make `RmControl`
public outside of this module (so each helper would construct it and
call `send_rm_control`). If `RmControl` is public then it could be
misused and sent directly via `Cmdq`, which makes it easier to forget
to check the reply status.

