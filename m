Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF64C44521
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E90C10E4D6;
	Fri, 17 Jul 2026 20:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZU4B7mRP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4794E10E4D4;
 Fri, 17 Jul 2026 20:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSDi9+RudgOXBYp+a0nTj4G1zky7pSsaUSMFa13qjJBpE2SwFnh4GKSSE/EClJW8hqitngsLzT0bz71Tix3LmKw89RTK34xgEtHTGey2WzhTPSgBKURpH+yrMu3cPEWqmxYZPur6r/LE0Dn3P4lHWx7COOHQ769BOeTpQob1aq9HDj7Y5f6XNsqkt3/QFwuApKVIUh+EWXRW6e2EDxlxtqvojcDDKJs2VwCTAhAjHQJPGm4txAYI3kZfHKZ4gtXBY+Z7+BQYrKzkqUCdISo9E0vzfJw6Lzkg3Jjf80YSP9js/QoWc39oKIL3AD6IVMfYy3SsNa/rp2dk7aYgSmI5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5iFOGCk+YxyUQ2SBshAw0KwzQARxrdBMsruzaBVSTc=;
 b=jWe0e59vuaYXsX+ntoQfwNWnrHD1dJ9kL9XnnrTKXx6bkReLrJPlWd4jNnt0az2TR2upq8H6m5i0DfcVQjeXaHQfOkWoXErb+0A880L/+DIK5C9+sSPI1C+sZcQ/pZFSpnBExuoCipqKUdH0ruvKhdTbngIhjDveeV3v0djwlIRn9ROMRXV2R+904jYT90/ITJBh9MZy3h9/yNcOZQuLzEzYuYFo16ZW4jDSgDUv2EXSNaEDQE4mGnoE5f/z0ZwhH1BwXMTAVVSWOge1eiBB0scKIng4ez3YYI+z6uPSnZYPGRaZ7hIHm+Ain3v5E5aPNBaoThuw25qGFkijyMqUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5iFOGCk+YxyUQ2SBshAw0KwzQARxrdBMsruzaBVSTc=;
 b=ZU4B7mRPnzyLE8ZmCKk3ViQURPU9/g7zOWlMN0xG7RJ9MkBWWsicQppETBZxEkFqIPAETWTN91dKpQMm4yzh9B2tPldTF4VjCzDXexPgQF/jfZo9WxlVc3QJGCO5Y+vmlylqTfhos22LxZbXWeJHHuTHxPlPcZ4prHs4/P65HFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 20:15:44 +0000
Received: from SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958]) by SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 20:15:44 +0000
Message-ID: <6623e957-6c78-4ec7-83fe-10fddd752aa0@amd.com>
Date: Fri, 17 Jul 2026 16:15:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display:Check
 dp_128b_132b_supported_link_rates.raw before link_rate setting
To: Jackie Dong <xy-jackie@139.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 alex.hung@amd.com, ivan.lipski@amd.com, wenjing.liu@amd.com,
 robin.chen@amd.com, superm1@kernel.org, meenakshikumar.somasundaram@amd.com,
 Derek.Lai@amd.com, wei-guang.li@amd.com, gaghik.khachatrian@amd.com,
 jack.chang@amd.com, Duncan.Ma@amd.com, PeiChen.Huang@amd.com,
 aurabindo.pillai@amd.com, zhao.xichao@vivo.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mark.Broadworth@amd.com
References: <20260630145955.13994-1-xy-jackie@139.com>
Content-Language: en-US
From: George Zhang <george.zhang@amd.com>
In-Reply-To: <20260630145955.13994-1-xy-jackie@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::28) To SA1PR12MB6970.namprd12.prod.outlook.com
 (2603:10b6:806:24d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6970:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b8d9a6-115c-4a35-694b-08dee4402e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|921020|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DOHUXSXQqLzd1SinnKUuS06B82dQsS/snW9jsg3EsObR/Rm6JoUMBvxPlUEaMMfM2+lzydc7Nce2xBjqu3QMFo6wtmocJLCXbHiCQ7CGP2CkO50mg8dQaeVnfJA8GTJ09v1mICap0rMyt9RMFv25XefQnsbJvwo0PQmKxmi3nqZbmxLdbnNYEz8wSzKFERsXGbqeIZdg6VTJThVtxXxZ7RwPoRBb0zyOJNDZ8sKRma9wsdTz0Ew4bcdw7vjpcWBdtyAI9mMEZdXPyDPxc2q9yxO4UgxE5eGMTbVBfrcxHsMWlmFX/hUAX0fHKQqIYoiKpDsmhOZjqSpNR4CV+hdfXXH3laPQhbWMATpgIcJ6YYaHwFM+xTEDFw73Nj2zndEZFyyqwiuXj9lNIl484LvdM2kmHRz85/pAN2JIhjvQlAJc8HjTlC9Dv/f8+C8IjgtAxzWjOQ9TsQ1Xfou9etz8yJWLXtqxXraEMSXtI77FTMdUbgynCvlKYfLxvr9HHw8SFbr5Yc+bTaaPe74hjfHdRln+dVv4Qn207a+hzNfF5MOZvCk6YYOf9B2H8uS4+TldutkBBrLtT3qq3XWmBrwBXvEQOwIULDZ5FazGDzYWIHniFcQQ6yU5F2RK6GxN69E900BqDS0HxjEDG8MD8eCBNQYpstbk/WzaVR80b92YDTJ/w5zWBpkr6z0kH60FwAGgyY/XtwySI2FvXwaslUho9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6970.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(921020)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTA4dE9EcmUwanF2cDB0Y0pLTUNyYmtRQi92M2UvWTF3SFlBK2xkZHJ4Qkk1?=
 =?utf-8?B?RnJES0taQXBZbXovU0Z1Um11WXJYRld0aU9ENDlNTjlRUzA0c2dnVExjSXhB?=
 =?utf-8?B?NVBlUTMyK1V4MVdDUTd5azFIQWN2UFJTS0pEemROTVI0T0NOeFJ4aHA4Z2xX?=
 =?utf-8?B?TGlRYTZYd09nY3JjdWV3dmNlMGVmalYvR2FaYnlUTFRSYWE4V2JGdTd4UDdt?=
 =?utf-8?B?akhKSDlGUk9UaXZ1WnR4OUxha1VBSjYwalYwUXVXNkFmQ2pmT3JiWTN4MUox?=
 =?utf-8?B?YTVXMXh6eW9sdGpnTkpMTnZtVkxPS1hCMTVDaUEzMmVvMHZRM29VYzRNVnFj?=
 =?utf-8?B?SC90dy9KSUJySG8yLys5a3gxOXhxOXAvckZBT251UEd3L1NhcTFHZUEvbW1E?=
 =?utf-8?B?djZMUzF1TENNL0pGMDJFczBJa1ZaMlFYQ0Jlby9uanBtVzh5TXBEc3VJd3Uv?=
 =?utf-8?B?WG5wS1JoditSQWRPWi8wazQwbmgydno3WXUyM2ljdE1raDNMTkRXazVkNktT?=
 =?utf-8?B?elJFZms2UlBLWFFaZGxaVVJ1dDJLU2NWWTQzbTZzckpsSkI4dVh1Mi9JbFNC?=
 =?utf-8?B?c0taN2M3L1M5L1JZRzJBU1I5MnU4Y2NqbGhhRlhJYW5TYStRVS8xaVN4VGxx?=
 =?utf-8?B?RUg4Tkwza1IvdmpWaklEY2lGWndWZUlGU3pLdkk4bDd3Y0NIbVNtNHhadE5W?=
 =?utf-8?B?VHhrRUZXcll4cXNFSTUzRGNUUndJcExibnRvMG1XZDJhL1dnV2poWUNQYjRP?=
 =?utf-8?B?T1RRWlBKOEJwSlh2RTBRcG1XR1R1NlRkZW1Gbmh4dXI2VUZFMVdPamQ2c2NY?=
 =?utf-8?B?K3E4UEhrUDBNbXdLWldOVUNBOER2RGhuci83eDhlZTkrTC9wOUdJMDRXWVFx?=
 =?utf-8?B?UE95Y1FNWkRUd3kvdDBPUm91Y1pCVlovRGttelkxSDhIUEdScW9zU1BpYXdn?=
 =?utf-8?B?dnpiMFlZekZna0IwUEFnUG9qdnlub1ZjWTZpRFJ5OUgyT1YvWEd4SWdHaXUw?=
 =?utf-8?B?VjlaamRpVVY3TkhkUU9KMDJVY3FBK3NYNzVYamxtZ0pLajVqSk9laE1pUHlC?=
 =?utf-8?B?aEdibytwWFU3bGlFTmQ4QWRHUk1LbmxnQjBrUjlPK2NCY1hjTGxjeHZIRmF4?=
 =?utf-8?B?REduNkUxSklLNjlBWThpM2Y1Rk9xSlQwSk5sU0FoZ1hZM0c3K3ZzSjZQNkhE?=
 =?utf-8?B?dUpxa0xBSk9DbHc2QUZNVUkvTWwwa09Rek5iUmMzUGZCTVdjbXYrN1VPUllH?=
 =?utf-8?B?TkFLRldIc0xsVytuOThMUEc5LzRrZTMySXFFakJHaG56VzBXcUxxcXRnaSsw?=
 =?utf-8?B?aUtZRFJrSlNjeG5weXdST2dhR0xtOXpHdllwZU9CZWozNUMzYnJRYlBpdE0r?=
 =?utf-8?B?UjFEaU1pVjZzMHExWXNkVGFhNWpMYUx2ZFhsMGhGTW9uNWV5dHdiamxxZ3Na?=
 =?utf-8?B?Q3RQNE1wVjZIMzBSY2swdXdob085OGVMeUtoaDNFQ2wrWVdzQmRSOXI3Nmth?=
 =?utf-8?B?ZnZKYWZFMDFrWENlZWhtVUZIR3NUb3dqdTFwNUw2NjRINjJDcm5hWEFTdGsr?=
 =?utf-8?B?d1VqOGtVVFduY2Ezck9iTHFXZGVnL1dTMlhOeEcrdjZMZ3FLTlJ5MTdIaFht?=
 =?utf-8?B?aVBNTmYrdFE2ajRvT1g4V0dzdDNFN09SVm81a0JxNFdOenhzMVpwSDA3aDNj?=
 =?utf-8?B?OWtkVENuQTB1RTN3cWFqVlM1RHZEQWxaZTRENGUwMHA4V1NqMTdOWFNqMWU3?=
 =?utf-8?B?UjRTSS9qM0ptMzZodFhQVFozSzFuYTBuN0lTRWx2YmZCMW5QemR3dDRaK2po?=
 =?utf-8?B?ZTRMSVJhTzhVa3FocWZmb21JZ1JvSTRjdlpQSEkyOG9zRGlKYW1GUW93SkRT?=
 =?utf-8?B?bk1XeEl2c0lQZUN1SEZTL2VvOEhYVTJaOUZXUkc1VzY2T1pmZUJ5UXM0L3kw?=
 =?utf-8?B?U0tYMitmR0FadFlBSU5WcXZsMExOTlhFOGIyWGVhalQ3cTNQbWdwRys3dGlG?=
 =?utf-8?B?Wm9ZM0dqZWJhd05Yb0M2T29QVGcxb1VKKzF6NDlFWk8wM014cEdHM0FBbjBP?=
 =?utf-8?B?STAzeEt5elVMMzZQNlpjMmNQSFpKdWxxZmMvbTlkZC9SclIvdmIrZmxHOG55?=
 =?utf-8?B?WW1TaXNMS05XU21yTlBRVVBwMlB5SUpJS1czVFZwbHRHMlpQRjBzUDdlMXdD?=
 =?utf-8?B?NTJrMzdUN29rWW5GUVFKU0ZZRVJNY2xaNEh6U0dxelZxNCttQ2VkdzhDVGFZ?=
 =?utf-8?B?NHZGQU1HNnhJdTBOSWdPWlVCR0xxaGdYSElyU3ZlRlh5aTFHS3o5aFZFVTdn?=
 =?utf-8?B?RlI5UmdJZzhSMFNLM2FjTmdvcDB0T1FUc1JZdlcrMXhEWU9VcEEzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b8d9a6-115c-4a35-694b-08dee4402e3a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6970.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 20:15:43.9949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiSd4pBRaSpiZZroi3XRVAV43Qrz1QzuJ+zoKe09cUAIwMpfNn56Pue+8MiNctomeBuQiOHaqep1Cw1fBwgmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
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

Hi Jackie,

This patch causes a regression when used with LG UltraGear 4K144 (DP), 
connected to Realtek DP2 USB-C hub. It is expected to be connecting at 
UHBR link rate, but we are observing HBR3 instead.

Thanks,
George

cc: Mark.Broadworth@amd.com

On 6/30/26 10:59, Jackie Dong wrote:
> [WHY]
> In the evolution of displays from DP 1.4 to DP 2.0, due to considerations
> some factors,such as cost, some displays support 128b/132b encoding but
> do not support UHBR rate transmission. The values can be read from DPCD
> register address as below.
> 
> 0x00006 is 03
> 0x02215 is 00
> 
> For such displays, the current kernel reports the following error message.
> 
> [drm:dp_retrieve_lttpr_cap [amdgpu]] *ERROR* retrieve_link_cap: Invalid RX
> 128b_132b_supported_link_rates
> 
> [HOW]
> Add new judgment: if all bits in dp_128b_132b_supported_link_rates.raw
> are non-zero, then further determine the specific UHBR type; otherwise,
> determine that the display does not support UHBR.
> 
> Signed-off-by: Jackie Dong <xy-jackie@139.com>
> ---
>   .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 47abb4066709..58cbb7ac8f9e 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -2079,7 +2079,8 @@ static bool retrieve_link_cap(struct dc_link *link)
>   	if (!dpcd_read_sink_ext_caps(link))
>   		link->dpcd_sink_ext_caps.raw = 0;
>   
> -	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
> +	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED &&
> +			link->dpcd_caps.dp_128b_132b_supported_link_rates.raw) {
>   		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_index);
>   
>   		/* Read 128b/132b suppoerted link rates */

