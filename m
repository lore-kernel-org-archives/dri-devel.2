Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFCECD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FBD10E274;
	Fri, 22 May 2026 14:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=symple.nz header.i=@symple.nz header.b="Blwi3gzX";
	dkim-atps=neutral
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazon11020075.outbound.protection.outlook.com
 [52.101.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38C810E1F8
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzyojayI+cTR8xInKkye91z+s1WIGqJIaho5xBDE3/vP0Z7UCU6p4Fh4//pdGImY8oqhX+Nv6F4GG0i+Vl6hQEotPf5HbFYKOcIW2uUYDqGUf3MV47R+bvb6rR34dcS2dJJjtGYV2/8k1t84ppmkKAyXlWAIHga2j+yFzSjKQ5WiPM5taJGa/uFXbfFWxY5pHiipR+vBJfz+ohMHOE2/GXe37ayZSV9vqVcuaDqUjloV1qo5YVcXWdIpWAJ12bdQvnu/dDX9/1QwX/TqbtPa+AYM8vsg2feYpmH5uic9Do9tMBEN3dm/RbyGWNO1TYWYxdMEJS4uriAgaFlUmMooaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbRbcqK6Fxlt9AWxOxSILSVNnVw8IlMp1RJSdwd0VnY=;
 b=AfpOeSUVaOR9ELCdJw7NFHMV8LwLIeEnt1ZQnoAXOAPnyGK6YnJ7M1T4BSjOSPXq/eKX5gIyOdkO5VINDBntODbMNUneZTv1eBQdILHWGdth6rb1bIuCaFcbNvAWlxgNbj59ezA59VO6FvccO7S2CEND9pext6ITf/ruMWXye8aQk6jLwSXNId/OyVvciLmQCfsI7Ix09SH8sN7vf5/IkfZ+FSfShWmYrdMgEwCnP1whHjOtpOq8AtXPoJJDuUe6r5vgM1UXaBazI1p/C2zcJrV5DuAEPgZB8164a9s5CKKiP7ljDj5mWIUiDFiac0x84wszbHmMMizhfyO4Ts/xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=symple.nz; dmarc=pass action=none header.from=symple.nz;
 dkim=pass header.d=symple.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=symple.nz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbRbcqK6Fxlt9AWxOxSILSVNnVw8IlMp1RJSdwd0VnY=;
 b=Blwi3gzXSSJp/Lww6rxwyA/UqPE2wKnxCEG+COw4k34Z1PwXZsVaXmsk4g9VCuCHT20hAsw8bLAZl1FqPFgEBTtoP9SZfgWFSEX/iiyvLoBm1QZCvTHazTyECizjJrjIUGiwLRGM/rUSSgTARTT4vwQNHkj6a0+d4D/kOUbApZMrzxZXihbppaLgyLeVUsdo3rpitUG9i9Ve1tVSbHpkPgjCNJx4drDfwMeLjvYdh426VdyTsWxXGtp5cJlLvolNVDhV9N12khQXZqHI8ocF07AVIupuFhvThf8gSd7avowHpEjucIj2ACA/Hh7GIgyyo7fZlY5TZLrLBiAt7RKCoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=symple.nz;
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
 by SY0P282MB6015.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:30f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 07:44:34 +0000
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834]) by ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 07:44:34 +0000
Message-ID: <af633f3e-bf02-414a-95e2-fed4bd04bc8e@symple.nz>
Date: Thu, 21 May 2026 19:44:20 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: compute audio CTS from N when
 not in TMDS table
To: Jonas Karlman <jonas@kwiboo.se>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <00a34a82-213b-4b03-801c-3c10b163d643@symple.nz>
 <81944af1-c9e3-4a45-ad42-3426dcab0777@kwiboo.se>
Content-Language: en-NZ
From: Simon Wright <simon@symple.nz>
In-Reply-To: <81944af1-c9e3-4a45-ad42-3426dcab0777@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0021.prod.exchangelabs.com (2603:10b6:5:296::26)
 To ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2196:EE_|SY0P282MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e49c819-d657-4397-f9d3-08deb70ccd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: SsCtVxM6NNAEbUM2Vu72UwiLLwC4jwTULhDOVpm0qbHAx5ivaqiJr3V9cfgEk0eu4dhP+mYlUZ7nGbpW68jobS+UQoKZpGOrLmYWfQs2PrwWJ4QINW0O17J34axAunj8Y/CZbTQqwtCSwZRcJgNMIPQqPBHs3o0gPNamNpwwRb489qlmm3Bxn13TIoZLg2DeETsad7m2zEdawr3k1bRg5lBXvmm4z/X2MYRrFKcLWdveo+UfA4uS32GQbocucX58pJ1EOX1/PnfsJbaA3yl249uAQlCdWYYgmhum2qaLJlF/VH3rmk/ghJVvwHudHjD9bJnT+GqbY1bEPwLwNlvYf1ZatmRVZW7zbrFSkVDbQNhNEL8aKCePT8AGpRak9emPHkb7xUxbifVXnru4wHGdB2KvXxXi/xgJU/09W+kYT3DYZUkup3859neUwrdvbHHThT4a0YP1pkGLFFgX/osRN4Iqqe+/easO0ev6iip1dwnTBDck0hPqu3/D96nJd7X6fTaj9jfpPuzNsinVfrYbaI4Z2Jf2ZXhW/pKYmizhF4fx5Q6DXUE260OU++S323KbPVn7o7sgGt+46dlQCvsoGZpW/fydHLbhpYjhoxkc9ImAtIYeiRX9iEFKzTXdYRiHOvjD/QnxWEwebGogUx+5KB3jn2DsF5R8lQ/H3mIAvmJYTfHe4Cps5+gZX/L4cF7ipleuC5eVYsBloVX/bu9dIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBwaGU5M1hkVlM2d2VsdldOM25OL2ZiK3E0QlJ3UnpiQjBSdm5XbTlOZXZt?=
 =?utf-8?B?Sk5jMzh4VExjaGxhZGRMVDJWZVd6K0VxY1pzSGF5U29RdmZrUHB3TDJ1OTAv?=
 =?utf-8?B?U2VDbkxiMkNsS25QUDEwb3pnWUpsdzM0SUVwOGg2VGFSVjVKVEJlZkpudnU0?=
 =?utf-8?B?dVdFNGFXZjBGREVuTlB6Zk9uSHlrY0tYdjRJQUtKM1lwRkNET0xTK3AvLzZX?=
 =?utf-8?B?Y3RSWlNBTWF1WUFvNTROQW5CRFNmQ0JreDJRM1JMTm1rRHVYYWsxbFhBRGNp?=
 =?utf-8?B?bE52TnFZSjh1K2JCNlNvVWQ0NVNPenFYOVBhYkhwbCswWUdINEhFOThnZHd1?=
 =?utf-8?B?VmZxL1BiRGdNdlhtUXZTMVEzOHNMTG9iYzFYM2VkbzkvV1g3MDZyWDlEK1Fl?=
 =?utf-8?B?Rk5uaERRMFQ2cUJBM1NwdnlCR1ozZ3RuQTBBOStCOTZCellRZ1cwUXV0aW9H?=
 =?utf-8?B?WGlFVldVZDJHUFNCRGxRWTdqRGt4QnVqLy9ycDRpSEdVTG5QTk1kQnZ5eFVO?=
 =?utf-8?B?djZlSUxmV3FzUTVueE40WUJjaTFPZjc5QlpxWjdCYkRGYTNIYTlIZGdMREI2?=
 =?utf-8?B?Y0V6bVdKaUhMZTBiMVA1R0VGbVlTV1dhZDllcW51dWg5WFdYcEgwcTRucjU3?=
 =?utf-8?B?c1NPemN3eGdHbmZNdzhPR2tDR2pXQ0pEWnhTZ0ptWW9wbEFLcTN0d0VFWHdV?=
 =?utf-8?B?Z1JkS3pMVFFxT2RtK0dJVTVESjA0U3g3K3U4ZGRuSVdCUXlmUzlpTzE1NmJF?=
 =?utf-8?B?RWI0OHJtaTRBeEEwQm1CVklvQ0RaRzBMbm9SVFdKR2pOQVZBNzVSdmJLOWpr?=
 =?utf-8?B?M3d0UTJUdzZaamZiK2pJNGlMbzcwR3ZyVjJqSDFvUVdmMjRaN3AvaHRySWhN?=
 =?utf-8?B?VEVibFU2d0l0S1dXZ0JGN1JleUI2SDk0WWxINzhwZ1haRkFrek5VM0RaRXNY?=
 =?utf-8?B?d2JGVDRqMUQxRTFZRy9WUjZCRmcwV2o2MzAyVm1zdHpDemhRL2s4M0JaQm45?=
 =?utf-8?B?Ujc2cXFUakc3Snp1dUpoSm53d042dlAwRnB0VHF0NHR0TFF1dG9wUlhERkpJ?=
 =?utf-8?B?eHVWbzEwTFl1RlhkTXNLN3NUelpZU29IMkZYUGFLUURscSs1TmRjQmdJRm1P?=
 =?utf-8?B?a280TU45dkM0WEVDdGtEcVlMZi9ERVZ1MmkxRGdqa2l1WURGUDFhR1VRQ2dV?=
 =?utf-8?B?RHpua2pxaGlCZ08yUDQ5bUdDNjFhK2FJNGN2YjMrRzhYbVRKU2Rsd1ZLTFpX?=
 =?utf-8?B?bFBNb2lwOHVkdjVKVTJ2ZGh3NEZWR3FWMGJ6UnVHbjA1UCtsK3U3Qk0xM1dB?=
 =?utf-8?B?QWxnU1VWVnR5anNnaDd2RWlMUFRYb2h2NDBVZ1ZCUmsvejZPQ1hlL3JERWMy?=
 =?utf-8?B?QjlwOWoySVVlRFZ5TzBWTms4b3hiREJOTHdpRXN3T20xbkZjcDZ5bERJbjZ6?=
 =?utf-8?B?NDhzVzJ2TFp3STkyMGVRZ2NMcmdOU0FVUkRSLzBBUEVZbWRCWFFvTFc3dlkr?=
 =?utf-8?B?YkltQWg5NnJZbjhWRlZQN2duN3FpdkpGYldwRzB3bHZxMmRNeHl5YkU1emxJ?=
 =?utf-8?B?UUFGS0FZdHlFbjMyc2laN2hMWjR3QytjTXJoSjMzM2NoMy9aSzdhYXpiRkNi?=
 =?utf-8?B?MlFTTmVaQXFJaDFCc1M1eXVVcmhnMXVoTlVYcHhNZWM5REFBa3hFSDhqd2lV?=
 =?utf-8?B?bW85bXNYQ0FDelJZT3U2WmdaRGZXWDZCZ3h1aG12eG1DRm5Kall2TWlISzNh?=
 =?utf-8?B?ZGJORFU0TmJhZElaQkV0blQrUHVJZStVd2xYZGRweDRmWGxycTVTdm9YRlN1?=
 =?utf-8?B?Q3VBc0JXQmVpWTJOdUVoemlrTlBGSnFlQlFUb0x2ak1nbmVseFdGYm1Gbzdx?=
 =?utf-8?B?bG5VZGF2WjVxR0J4V09jK1c1VkhqbFdWZnRWYWxSa2lKejNqZllsRUw3UEdh?=
 =?utf-8?B?UElwQUZjRXhMU1NPaFNSQUdXclY0N1E2d1ozUDBBaDdvMWIvOURJUldoWkJa?=
 =?utf-8?B?d05wUzF5eC82Z0xNYTZLc2xOalVDanh5VUdObGU4NEVDcDl4YThlTlFpcXRK?=
 =?utf-8?B?YU9QKzNmZk5YeDdMcXZCVzhxRld2QWVTSlNLSXQrbTNDRFQ2VGp6WGJsb1BN?=
 =?utf-8?B?bWc2azBOZmhtT3RRTEVTdzFIelh2bEhKMGVRcnVjS2xuR1MxeXRSSks4bko2?=
 =?utf-8?B?V1krU012L3JLVGtmZXRyMHFwdXozeUc5UnZQK0FEeDNlbVZOZXhST3hXbVA5?=
 =?utf-8?B?OGYvekhwSitiRVpUOWcrOGEzaUhiY0IybERsamNZMHJ5YTBQb1hXcDBNU3pI?=
 =?utf-8?Q?OjXESKiQGqX2+HqxXA?=
X-OriginatorOrg: symple.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e49c819-d657-4397-f9d3-08deb70ccd4e
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:44:34.7275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9531f271-068a-4210-b471-bd8da91491c5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v55b9fCs/ZGKTq8NehhNa2sv3p6j+smldBYd5E6EMFC2GsBsyFkKXjYljZXyCu0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P282MB6015
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:05 +0000
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

On 20/05/2026 9:38 pm, Jonas Karlman wrote:
> Could this function instead be converted to use the helper
> drm_hdmi_acr_get_n_cts() to lookup/calculate the n and cts value?

Done in v3:

https://lore.kernel.org/linux-rockchip/86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz/

Re-tested on the LG G3 OLED (the original reporting sink) at
148.5 / 185.625 / 297 / 594 MHz; audio plays at all four.  v3
also drops ~200 lines of open-coded N/CTS tables and search
functions that the helper makes redundant.

Simon
