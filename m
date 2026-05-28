Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED58CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 12:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1227910F13F;
	Thu, 28 May 2026 12:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="0fBgfExN";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021108.outbound.protection.outlook.com [52.101.95.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E48D10F13F;
 Thu, 28 May 2026 12:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Cm0QSKpsgWh+QOht+8ulPFs1IWqkfbu90fz3Y/uejltbjSLoZJuoEMGXNr5261ftIjE07waHKYS6uAiUGkC6d/A5NuXIEg814vfsZ0rSmY+JcGTs2lA/nN5qcfHzdjzdIbNSNiw9gMuqK8itcX9I5lVh0R9nG4pLaYOMgQC9HBoMApxGcUhMVmC84fIQkyYZhqqWXr9u+WK2m2ni0xO+e3Tu0BMMJuAr8alkJTv/6fbtSybILfz6opiNKZmDFACmnMSfeM7WR+8FHi3fN3xS5qTd9cbbFPrfcqxwi7XpJrFvWmiUC0qaw5Qzbif2HNI7Osx/37GNMrXBTJXhCaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IqVF/CkpI8SRV4jV2kHl+eRR1ibZR9Cp1zZpf/a3nQ=;
 b=fquV9daeI48Y0JYWXjSdEo+Zp9X1K0nKd3GH+vbLFdi/nMxh4l5lcMDuRv8RClBTG6v+TaaXm9EFGOYE6j/+zjj9tiFDtL4Olg4SCTkVPsP375aCiJJVDVmEIX5/TAhoU8K9FVr97TvJqcu0UMMPmW7Pe0yGMI4+g3rff2LO0DItovRVS2bGBTnOFMRvF3gpAkrLTn0k1Y/I+S5nDRfLcyBeQctO+r7ODhL1oYqkUtjJhm43hXsYSC9PnEuY7BMB0uwfOdUSfeAH1qONtQvjhkae9w4M7p6McKgWJgld/pQz4Y3pSHBbNpxMMXWB2rl+/aYfR0l5BwSqUyEI48uJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IqVF/CkpI8SRV4jV2kHl+eRR1ibZR9Cp1zZpf/a3nQ=;
 b=0fBgfExN/dgUjXqSMQpsblpCSpZapHRtE4cd1ePww5K8wrNhVPPt9qA+chPalS2IeQGmRjK5fSSWbGhO8T+lksjsn4R5QjiI1VtWgcnIMRliXhPdo2wPmCLTT98KqS/kauwMFCOVHnhwFKEeQ497aIzTNYo56kzFMVwpKeXf1DA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8883.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 12:58:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 12:58:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 13:58:35 +0100
Message-Id: <DIUBT4GXKI2Q.3RZEYJVWXZF18@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Deborah Brouwer"
 <deborah.brouwer@collabora.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <boris.brezillon@collabora.com>,
 <gary@garyguo.net>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: drm: tyr: use IoMem directly instead of Devres
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-3-dakr@kernel.org>
 <DIS9H75POYGW.EBC1MLW466RG@nvidia.com> <ahd4UoKVT4cM-pgA@um790>
 <DITUMY6K2IQX.17R1VUFJGBDAW@kernel.org>
In-Reply-To: <DITUMY6K2IQX.17R1VUFJGBDAW@kernel.org>
X-ClientProxiedBy: LO4P123CA0111.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 7960c0f5-eb21-4187-0704-08debcb8d43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RWmJgXVQI2IYD4Z/96KjfXJdJ+PFB41VzPP0aOtdyahQ2qw6DJItPx5tHuhZ7BqxKcdjTRnCQbsmzO6oHSep7tFrrDZUUSEWO4kou653AmaWdLvZzD/zLCG3UMVO0UGcRycBcen8tyfbvNEsJIkWGe/3ml5ILdeU5RZ5A1ZCWxaJjZ4oDToH6CPYDgzplMCp9rcNnvYvld4zmLnRVSvJ8VT7Sk0mLC7BWeKgA+ZHgo2qNoZUbJlDpMsl1no5kd7bRtXW18RssDEnLr00Cc0HNGRxEngJcDiCuhsDEt6EFn7teBnbHZKNPWfLVs6KoriSprhtfKqA6+jzq9A3k53I6p3Ke5Sb8iQVUgDZPackrwNrKAzrHML1calJpyXuCRfjrKJD03p9kgiCBQE1kZkVJYDPNE00glinIpaJdHAUF7vJphY/5FFWFavyLQEgQvw85gSp5sGPpgCM87dN4NJbCdr+8ybHQhyQykvbCB/0Yq429IjQbgiPvgS4Y3KwvW/SAnIySpzLu9+U55HhO7g4JQFxFD64DCPWbZzUKkxbx/F8sIuRM5eKwvfsOMgVRBy24avjms4GrR4TiF9scJbACvCLaFXAGYLkYFVBOQFclRQWFH17AUApgqyglgbSW/GPAAsPqBp2E2GSAKRzwrAAya61prxh4Rbj3iGw47zx1RwD7ycahIUzsn/bxIR9MxAC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdPL3l4REFRaDZEbEFpRmJmSVFzbmRhREx3elR3VVV1a3BlLzYxWlJ3NzA0?=
 =?utf-8?B?a2EzRFNHS1MwWEtMTkowbmY0Tkp0bTkrLytqcnFwb3dqVUdDNkJuZGU5WWRk?=
 =?utf-8?B?K1ExaHUrbnZibmtjU1dvd2owNlpBckM1a0NrQTJRdzVnQ2wwUWNDUGRicGg4?=
 =?utf-8?B?QnlJcmdxWWVkZHpqVmxQcUFrVFZaUUpTVG8wMVlrUkI2Q3hmQk5qL05LZlMy?=
 =?utf-8?B?N1ZFTGM3Vlo0THdKZVVOSVNSa0syUlJiK1k2UDVlaEN5RFdSbnBrVlg0RjF3?=
 =?utf-8?B?cEQva2cxUXMrN3hTbmxENzMyazFXU1hQSnpuSWhQM0FXaW1sVXdNWEFoQ3pp?=
 =?utf-8?B?VjFhYkF5SENOYnFYRjczS0VqWDZFOE9QNzJ6a3duY0dVc0NlK040c1VobUZu?=
 =?utf-8?B?TkJIczVOMFVxRzh6VmNKVTAxYnZVTmdvVnh0QUh5YVZtclRocVU0cUhLcVRU?=
 =?utf-8?B?MnNjTXVscnhQclFPeUtiSnFiRm9KbVJ1WGU0b1NUSWlVWnJPaUhDdUNXMHht?=
 =?utf-8?B?a2NaY294ZlpmVm5Wc2hlcXVFYnVXNytuYUo0UGNRdkRvc2VUbkh4czFTMGdX?=
 =?utf-8?B?eWtzUVBjVFdvSXVQVm5Ibm1JYUV1MVkxZnVtblZYc1FWaFl6R0dCYyt1WFhI?=
 =?utf-8?B?dmplT0QzUnVMdXpZV0ZucTZsQ0oxOGNJaUxNcElnY3hIbkpxYytLb3hJdWlY?=
 =?utf-8?B?WFVuQzJMa2FNalFMdXlsZ0VQUVFuYlhDcFBjem80d0hVeHB4LzVvUjBKSHpy?=
 =?utf-8?B?SEFvMUNJcTJlOWJTODhEclZNcDRRN0Q4LzBIb1h5akdFQnpFdXdSQmJsaDhZ?=
 =?utf-8?B?dmx6RUNQWm9ucHRXeWd3UUw4YXc5SHJQZWU1VGE2NkdzbnNFcW9VOUxkdTFu?=
 =?utf-8?B?ck5CamEydkQ0Wmh1VzhONG1SK2xDUTZCZHBxNUdPY0R5SjFVMFhWNklJd1lq?=
 =?utf-8?B?WDNoYlkwOFRFSkVWTVlaNkg0MDIwOW9pcXNDYVM0MUprMjhqYzVnSVdOaS9W?=
 =?utf-8?B?d1JLQVpBNmkvRG9kN0ozdTVITHBqY0ZoZzhWenJFN09sWGM5UjczRk9YRWJt?=
 =?utf-8?B?VkszNkhLRytIbEgyTHExTU45MEhkOEJZN3JNSkxUak14V3djTTVMRUVwTzF5?=
 =?utf-8?B?UGxidU9MMy9FU0krWjVhNmFBdTRvS3NwS21UNitnUDZTU20vR2pydis3RzRw?=
 =?utf-8?B?Z3orejRmZjBraDJEOHJ3ek50WXNnT3plbUE2Yi91a0MvVUdOM3NTeHJXeHk2?=
 =?utf-8?B?U1RWbWhJSVd0MXVXSXBsTWJiMEQrVGNYUlZJZm1vMEFqQmFtdnZQaU1XUUZQ?=
 =?utf-8?B?Y2Q2QlBEZ2RKODFScktFamFnbzBBcjNFZkx5azZnTlBIRlRvdkpRTnB4Mmhv?=
 =?utf-8?B?dzNWcGJ5SGdPSy9nRUgxV0s5RGhqS0ZqaGw5SytTNXpsQkw0WlpNVjhISU9k?=
 =?utf-8?B?WEk1d1U1K3Z0azZ2c1AxSzI3ZWhrdndoTmtZYlVKd00yak5qME1wUmhVQjMx?=
 =?utf-8?B?WERuZE45TnROMEVGZWlKSjhta2xHTHozbElhZ3E3eEFzM2ZMT0NxbVlIeElT?=
 =?utf-8?B?VURWWG5zZmJwQXQ5NjA2OXJJM3MzYkNacWtPMVJGUmNoODVNeHlzMEp3TWR0?=
 =?utf-8?B?Y2QvQlJtTVdjMUw0SUJ5a2s3OWlDOUh3Y2o4eDVqUTAxVGtEL2RJWlBMWTBQ?=
 =?utf-8?B?NlEvQzJIQWN0TUljb2dURDhFRWo0QXpSeFNMb01tTDdOanZkSzRvVEhZOVhv?=
 =?utf-8?B?emt4Yy9jWTAyRGdSdFJKSzFjOC91N0czVEZENG4zS2dBYUFWL2tVN3NZWUJQ?=
 =?utf-8?B?QzBkVmRCbzV1a3dQSGRIL2JMWW02RTBrWXkrQ2hSMzJFTTNuZGQ4Z2QyV1Nw?=
 =?utf-8?B?VnVDSlJrVGJ3V01yLzBSR1VTVXFkMHdVelZkYXo2ZHk2M2lTeUp2YTc3TCt2?=
 =?utf-8?B?dmVXRTJjbTR4dUtHc2puajFjVVBZODV3Q3ZoM2YvWUo1OVUxaW16b1I3cFJ6?=
 =?utf-8?B?S0Y4dnhEVDNHdTVOSmtKRGdnYzdCWEhSd3hlZmlJUGhDaCttd3lkMXlHNkJt?=
 =?utf-8?B?cXRVM2pmU250bjB4MVVyR3l6aUF5eExYNDJBdEpqaFJYaEQyM0d5RDJUMlNt?=
 =?utf-8?B?YWE3dUREMHQxMk5LMnc4bE9ITFFIa3pIV21sWDdGZjdQR1dSQlZuM1JCVTF4?=
 =?utf-8?B?N1Q2VnJINHFVbUxUMGhBSUdaS2ZPYnhUeDI1elkwY04rMmhxTFdzcnEySk1m?=
 =?utf-8?B?dEhUUEw2Z05JN3I0QmVoSUhWL2VHTnA0eWpHWHROejM3Yy9lajQwdGR4Qzlu?=
 =?utf-8?B?aEo5ZkRoQU9vMjJpRzM5STBvU2xxUnVYK2VFSW93T3cwRTV2SDdZdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7960c0f5-eb21-4187-0704-08debcb8d43e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 12:58:35.4724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28ES92525aG3fGiux/DNDx9IvmhV5Y7b1hWQjyrdiF6S4X9cydbVJhO++VbTnsuZ+KZc/IEdCV1r8w3VupVsYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8883
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

On Thu May 28, 2026 at 12:31 AM BST, Danilo Krummrich wrote:
> On Thu May 28, 2026 at 1:03 AM CEST, Deborah Brouwer wrote:
>> On Tue, May 26, 2026 at 11:43:38AM +0900, Eliot Courtney wrote:
>>> On Tue May 26, 2026 at 8:01 AM JST, Danilo Krummrich wrote:
>>> > @@ -40,9 +39,7 @@
>>> >  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
>>> > =20
>>> >  impl GpuInfo {
>>> > -    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) ->=
 Result<Self> {
>>> > -        let io =3D (*iomem).access(dev)?;
>>> > -
>>> > +    pub(crate) fn new(io: &IoMem<'_>) -> Result<Self> {
>>>=20
>>> Perhaps a future patch can remove this now unnecessary looking Result i=
n
>>> the return type.
>>
>> Oh that's right now that we don't have: let io =3D (*iomem).access(dev)?
>> we don't need the Result anymore.
>>
>> Danilo, I can add this fix to our fw-boot series which I'm preparing to =
sit
>> on top of these changes.
>
> I can send a v2, fix it up on apply when I get an ACK, have Alice fix it =
up on
> apply, or have it done in a follow-up as you offer -- just let me know. :=
)
>

I think it makes sense to have a v2 with this, as getting rid of impossible
failure paths is the reason we go for lifetime in the first place, so this =
is a
good demonstration of that benefit.

Best,
Gary
