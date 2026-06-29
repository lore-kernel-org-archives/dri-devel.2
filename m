Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA8CC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97BF10E9AD;
	Mon, 29 Jun 2026 16:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vL/smArV";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA3710E9AA;
 Mon, 29 Jun 2026 16:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNsXYXnsT4BNnHGjCxQh+50IEGlqh6b3RHnzDGbtIPByO4sgwwk3pO3/QF6bt39bFRbQzV+sgQwPcmGGbqBc7HJ2BkaOz0T5fy1N4y7pfyWTWK6wi/mhf43ODorWVu/D5yxivMQdtpDZ+EELvp2mh8LRCgrnO6nlgNO1QPdM1A0ZpZH0HKFf0qYiPn1FAX/3FG6DoI+Ou37WSIj0upb75vPJBrVpgvBK3PzUzDfj1YxymO2mqNNRuZm+ezPa6wsBFoSbyPZ9DS4MOgkKZFlmTelJH5LiUMN2y3p/2qkzswZsqpi5P5vyN/FwR2KNurF4e0RPIHI/QB1dQh6hqiwoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjQg6OtS/xQHrVrI1hxIDZLC67+xdrAQClGDaIaX2jI=;
 b=n1TeKze1bOzZvvI8lg7edm3jt7W44+sDo6TL1oS0dCHjiXt57ItdSfTAraL/AV0/h/ju1p/4sPDi92rXmJPIdU/61cQmvED4Kf7Uc7IlhGVfHL3YfM5rHT4g5f8q4q270d9HdnLQxK9C9yikqbWaHr35hgNATOc3g8F37kybPGkbkhtLukpkRLCXGZ9ZGbUwcn92dclcaPlZ1U8Ne623ob2R+kB5kLSUIelENnDRjDCw6CRZzoh9oOinhgvhP18ZnuM8m24gI/YDqw4J1OR2FUQuSAbloPh4GdMok/RNbKXDmzQXf3RZlyRvsscdBLYnTctUOvuzlgqhlmupubEi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjQg6OtS/xQHrVrI1hxIDZLC67+xdrAQClGDaIaX2jI=;
 b=vL/smArVv5bBygGzsq435saRnwJd0obq10DkKTTEs/8wC2FcD4S2nzg8+MGMS5KN4M1DhWMzp08QdW6+MRffwd72N+laEdBES14fwDHUZKfbsJZKhFpo3H6xfo3L1JfOeXqIohtWjghqcj6/aBoTaG+sBaoKe9pdgmWM5GKpkOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 16:56:44 +0000
Received: from SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958]) by SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 16:56:44 +0000
Message-ID: <3d303f39-433c-4ccb-aa99-9b832cefe435@amd.com>
Date: Mon, 29 Jun 2026 12:57:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] drm/amd/display: quirk malformed CH7218 PCON
 topology
From: George Zhang <george.zhang@amd.com>
To: stevester.codes@gmail.com, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 Mark.Broadworth@amd.com
References: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
 <b9256d5f-ac08-46cd-ab84-3fc0e6e52b61@amd.com>
Content-Language: en-US
In-Reply-To: <b9256d5f-ac08-46cd-ab84-3fc0e6e52b61@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0400.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::10) To SA1PR12MB6970.namprd12.prod.outlook.com
 (2603:10b6:806:24d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6970:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: cae6c6df-e825-4bbf-1f21-08ded5ff661c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|6133799003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: ltRb5uKl6zRyjDviIzQoe2mOmDbANhFeXb5Da+DUxVuk1b+RXyai86kCPaLY5PXM7l4Cs4ryeeAp2jl3rk8m8uMbrnzT9hghZNdJNFe9w7UCA30HNLPC0eJkOSOwsT2jxxMhmIle1j2wToDoC/enY+3pMP4+whY4jTsJhoWvQ8t+nZ+aRZ5ImeGVDMXH7kIzUkZvdpKwKcAD1h7iAYnCiz2XAyqk2ZLitHBQnDIBJsmLx+uDpyvv2nqtLmyALJX4+CzMrct0aGct1AFUGit0Mrqko+gdU1VUiUtVqVFapQmrTuCApUMVTvBIVgdTZsA3WRMLskQTbu8u5W57gLKS9gOMMtJbiu8qp8yCbMk04J8nM2fi+/7Pdmms+WJX3TcBIB7fMxgwlmxB3KuFr/tb+mULUvcnBRoFwmK/C9iYfjPF84IAiVeGtWwY8e6GjlTnxNSKiZ32u6QOVOoLkzkYwKVkikMWh4i+qMufCNQDIV9tSrD6MEDh7Z7VKJRP+ft/vhMA5DDqJuwmxpdbgRFd3EeT4But0r3isR9lHRTODrpjhqg2d//mgkljn8r2NHqdD063Oc019WEStYsm6ioEiJfJwhkOz2xPKwBlvXcGxi/tkCYQvtpVUs4McxLNsjEpdhT7nbL+5lUSUlmoQBOvX620wBKBp2B5dIToIgXN1jQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6970.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y284WlJqYnQwSzJUVG1VT3F4UkpoNDBHdktnSTJSS1Y0am0zaXZEengrL0k1?=
 =?utf-8?B?eThHSThScGRMUnI0SEk5TUIvTFNSZjRFV1FhRkRwYXZPTjJUbkV5Uy9ocmM3?=
 =?utf-8?B?NCt5YmttUmRoRWJwVkVmeDJzMksvSVFxajJJZGlQajlZaTJLZy83NHVHT2Ez?=
 =?utf-8?B?THNvbmdZTWc3Ri9IZTZ5U0hOVmpFQlhjWk94M3kzNnVkaVhCSk9paHhRSis3?=
 =?utf-8?B?Z3llS2dJSlRxVU9hbWdGSzhST3p6MDRNbDNSejhTMXZLQWxyakhqOUhaMTZz?=
 =?utf-8?B?MGg1Y2w1amZ0S2ZCMm4vdlNzWTd5cERheXMzenJDNlNENEFpM0gzczdQck81?=
 =?utf-8?B?b2hTMDRCc0w4UmV3cklzOFNQMFJ0T1BqUXdLU1hsSTh0WWtmZ1ZvNURzYVRw?=
 =?utf-8?B?Y1ZzdFNiYWNMeUptaEJ6TlhqdDc3N0pEd1FpN0ZNWWsyVzlsbjhrOVh3YllO?=
 =?utf-8?B?dy96K1YycnBnbHZEYlZEQTFZQmlkMnVqakdKMXc0UE5RWXFHZkUzYTEvR3JP?=
 =?utf-8?B?NUs3ZTh2dFVsLzdGVmdYdEFFMmpQdkk5UE5SYjM2ajhPRHozeW00TEJzVFBG?=
 =?utf-8?B?ZW0wcXM3M0pDMnFCRUdnNUhDUDlWZUhlQU9mQ2RnT2JYQ0d3aU1vaDVnNENh?=
 =?utf-8?B?MnlOcFNmOU1LenZNUGltS1pFMFJua1hGNjlZL2JmWGJ6MzFpQzIwNlR1OXds?=
 =?utf-8?B?QjgrY0RGUmM2QWpJTHdUMW1wZkZOdTlJNVlXV0ZvUTNEUXVuSEs5SXIwMkxL?=
 =?utf-8?B?MC9oTU01Q3BjbGtCaExuY1E0U3VOU0ZIU3pkQnVkdTA1dk0zdXZCWmxTOURU?=
 =?utf-8?B?UHdudk5mdWVlVjEzR1NqMGducDkzTGhORTBCT2w5czJqU2paMHVFMHdJSVlI?=
 =?utf-8?B?ckhjUlR2NHdsTHUyTzdmZmw2dWxIcWUwRVJ6MDNZU28yNGI5VldXZkJ4TENj?=
 =?utf-8?B?WUJ1VDNjTzdBTEZyY1JIRjM5T1VsdmM0cW1oR1ZCSWZieTRoYUhTMGVqYlda?=
 =?utf-8?B?dVM1SUxHU3B6R2NlT2FQbVdLdEx3ekQ4MHNEUmNTcFpEQkJwVzVmRmo1elpp?=
 =?utf-8?B?OGsvMXB3T3dGMTBCSGxVRjdiam1OSTluQmUySkxRVUl4VGlQN2lrUy9lSCtm?=
 =?utf-8?B?UGVvNjAxbzBWTGErcWkwbFNFMERadmRPc2FFVUlqTVhITnBKSm1XeStWdkl5?=
 =?utf-8?B?emNxaUVwb1A3MFJWS1MvV3RSUVV3VjNqNC9nV2ZTQ3hJQXM0d3RzYkwyd2Y0?=
 =?utf-8?B?dldzaGtvWUdZanN6SEcxcTUwMDlpOUJDZW4veGw2emlxaDlEY3JWNlB6akFV?=
 =?utf-8?B?WVdldnhhWjE0KzBZaXh3UmpReVp4dE44TmViY3pOSTVabVU2Vk51WWF0Rjh1?=
 =?utf-8?B?UHVqZ3A5RnRaYzdPTXp0NTdacURKQ2w3ZVhLa1ZaMXd2SUh0VFMxSkdVcmZ2?=
 =?utf-8?B?TmUza3R3UkMrMUtDejM0Sko3YWxNbnJoQk1qM0ErenM3bUY0a2NtMFJnUGE1?=
 =?utf-8?B?a1hZVi82ang2dHlIRlJSUFduMU1Xdy9qQjQ0dDZwelpsS0x3T1J6VCtxNmVn?=
 =?utf-8?B?NW1iUTkrOUt5eUpLV0U4Wi94eHEvWGVQL0tVQkNKZ0ZXdThHNzJsZDhzZHBH?=
 =?utf-8?B?VWxsVDB6c2NFUTBDd3hyczRJVWdZL2pIZjR4U2ZWQ2F4VVpkaG5rMGRFaVFD?=
 =?utf-8?B?NXc4dlB1bnY1ZDlYQkpzc1MzWlNhY0NCNStTeVJiYjNiTENiUzY0U2wwZzRT?=
 =?utf-8?B?N2pia3pMeWg5SHpTNGVkUFY4YUtBR3Q3VkRvVHY2OHB1Y2xxM1VzeUVveXdm?=
 =?utf-8?B?RklNaEZ5Y2dFSFJzZTRrMVRMUEZiQit0bWNYVjFVN1d6WlVwMFlaakxPL3l1?=
 =?utf-8?B?eTRNMTVQaDBZTnVPYURUaTM1cTE4MUt2VjNHWGhGM3VZc3JrSFlENlRjcGU3?=
 =?utf-8?B?TFVzZEs3ZHh1a2djV3U0UDNkRHZ5WkpEU3dxTXl2bzg4eGZYMnVFaDVuZWJj?=
 =?utf-8?B?MEg1RTdBMVVScnBkT2VsSFdUQXd0eEp0anl0ZW9FdFRtc0hRazJMQ2hjKzIx?=
 =?utf-8?B?RHFuSFlYR3MxM3NPOGRMNlJ3elhIZll2STJ1d1AzbGtqbHQ0WC9XdjZMRlc0?=
 =?utf-8?B?UWFIZk0zYUt2WWwvNnZtZHZxZWFycWUwL2ozU1JBM3h4NTZyZjBLNjhNZjVu?=
 =?utf-8?B?Q3NnN1RhdEtsQ3VweXZaVUVxeTN1Y3B1US96b2hwYStHTVJlWUkrZGVSa09H?=
 =?utf-8?B?dkNLMjdzRFBuRXhxSVpLYjNEK1FXbysxYVAwS1FHaHgvbzdqaU83S3VpWGR1?=
 =?utf-8?B?WE5aMjdySmpZTlo0VERwWmRUb3hkL1lPcFk3aW5wcUZLODVsY1pIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae6c6df-e825-4bbf-1f21-08ded5ff661c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6970.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 16:56:44.1540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN3qcSJmznDXB+GjAb1PSMDGDvwS5FmZzRny5pKpwTDVVJMhcSk57qkPgICxTAhuwin4ZRAshlK8Xd4CQiD2DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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



On 6/25/26 4:39 PM, George Zhang <george.zhang@amd.com> wrote:
 >
 >
 > On 6/20/26 12:06, Stephen via B4 Relay wrote:
 > > From: Stephen <stevester.codes@gmail.com>
 > >
 > > Some Chrontel CH7218 DP-to-HDMI 2.1 adapters expose a branch
 > > device ID of 0x2b02f0 and branch name CH7218, but report no
 > > downstream port at DPCD 0x005 and report the detailed downstream
 > > port at 0x080 as DP.
 > >
 > > This leaves AMDGPU treating the link as non-HDMI and bypasses the
 > > PCON capability path.
 > >
 > > When this malformed runtime state is detected, classify the link as a
 > > DP-HDMI converter and restore the documented converter ceilings needed
 > > by the existing PCON path: 12 bpc, 48 Gbps FRL, and YCbCr passthrough
 > > capability. This does not program the PCON or synthesize source-control
 > > FRL state.
 > >
 > > Signed-off-by: Stephen <stevester.codes@gmail.com>
 >
 > Hi Stephen, thank you for the patch.
 >
 > What dongle you are observing this issue on? We are interested in
 > reproducing the observed bug.
 >
 > Thanks,
 > George
 >

Hi Stephen,

We observed a hang/reboot due to these patches on DCN42 while testing
DP2 Link Layer Compliance:

- 4.3.1.23 - Successful Link Training to a Lower Bandwidth. When
   CDS_INTERLANE_ALIGN_DONE bit not set during CDS phase

- 4.3.1.24 - UHBR Fallback rate table validation

Tested on DCN42 with M42d compliance box via USB4

Thanks,
George

CC: Mark.Broadworth@amd.com

 > > ---
 > >   .../display/dc/link/protocols/link_dp_capability.c | 47 ++++++++++++
 > > ++++++++--
 > >   .../drm/amd/display/include/ddc_service_types.h    |  1 +
 > >   2 files changed, 45 insertions(+), 3 deletions(-)
 > >
 > > diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/
 > > link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/
 > > link_dp_capability.c
 > > index 47abb4066709..c2b48abfe7e6 100644
 > > --- 
a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
 > > +++ 
b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
 > > @@ -1158,6 +1158,31 @@ static void 
read_and_intersect_post_frl_lt_status(
 > >       }
 > >   }
 > > +static bool is_ch7218_pcon(const struct dc_link *link)
 > > +{
 > > +    return link->dpcd_caps.branch_dev_id ==
 > > DP_BRANCH_DEVICE_ID_2B02F0 &&
 > > +        !memcmp(link->dpcd_caps.branch_dev_name, "CH7218",
 > > +            sizeof(link->dpcd_caps.branch_dev_name));
 > > +}
 > > +
 > > +static void apply_ch7218_pcon_caps_quirk(struct dc_link *link)
 > > +{
 > > +    if (!link->dc->caps.dp_hdmi21_pcon_support)
 > > +        return;
 > > +
 > > +    /*
 > > +     * Some CH7218 firmware reports no downstream port, or reports the
 > > +     * detailed downstream port as DP, while the device identity and
 > > EDID
 > > +     * describe a DP-to-HDMI 2.1 PCON. Restore only the documented
 > > converter
 > > +     * capability ceilings here; do not touch the PCON link state.
 > > +     */
 > > +    link->dpcd_caps.dongle_caps.dp_hdmi_max_bpc = 12;
 > > +    link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
 > > 48000000;
 > > +    link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr422_pass_through = 
true;
 > > +    link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr420_pass_through = 
true;
 > > +    link->dpcd_caps.dongle_caps.extendedCapValid = true;
 > > +}
 > > +
 > >   static void get_active_converter_info(
 > >       uint8_t data, struct dc_link *link)
 > >   {
 > > @@ -1166,10 +1191,19 @@ static void get_active_converter_info(
 > >       /* decode converter info*/
 > >       if (!ds_port.fields.PORT_PRESENT) {
 > > -        link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
 > > +        if (is_ch7218_pcon(link)) {
 > > +            link->dpcd_caps.is_branch_dev = true;
 > > +            link->dpcd_caps.dongle_type =
 > > +                DISPLAY_DONGLE_DP_HDMI_CONVERTER;
 > > +            link->dpcd_caps.dongle_caps.dongle_type =
 > > +                link->dpcd_caps.dongle_type;
 > > +            apply_ch7218_pcon_caps_quirk(link);
 > > +        } else {
 > > +            link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
 > > +            link->dpcd_caps.is_branch_dev = false;
 > > +        }
 > >           set_dongle_type(link->ddc,
 > >                   link->dpcd_caps.dongle_type);
 > > -        link->dpcd_caps.is_branch_dev = false;
 > >           return;
 > >       }
 > > @@ -1200,7 +1234,14 @@ static void get_active_converter_info(
 > >               switch (port_caps->bits.DWN_STRM_PORTX_TYPE) {
 > >               /*Handle DP case as DONGLE_NONE*/
 > >               case DOWN_STREAM_DETAILED_DP:
 > > -                link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
 > > +                link->dpcd_caps.dongle_type = is_ch7218_pcon(link) ?
 > > +                    DISPLAY_DONGLE_DP_HDMI_CONVERTER :
 > > +                    DISPLAY_DONGLE_NONE;
 > > +                link->dpcd_caps.dongle_caps.dongle_type =
 > > +                    link->dpcd_caps.dongle_type;
 > > +                if (link->dpcd_caps.dongle_type ==
 > > +                        DISPLAY_DONGLE_DP_HDMI_CONVERTER)
 > > +                    apply_ch7218_pcon_caps_quirk(link);
 > >                   break;
 > >               case DOWN_STREAM_DETAILED_VGA:
 > >                   link->dpcd_caps.dongle_type =
 > > diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
 > > b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
 > > index 53210e3aa0e0..4164f8a5ae56 100644
 > > --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
 > > +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
 > > @@ -37,6 +37,7 @@
 > >   #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
 > >   #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
 > >   #define DP_BRANCH_DEVICE_ID_001FF2 0x001FF2
 > > +#define DP_BRANCH_DEVICE_ID_2B02F0 0x2B02F0
 > >   #define DP_BRANCH_HW_REV_10 0x10
 > >   #define DP_BRANCH_HW_REV_20 0x20
 > >
 >
 >
