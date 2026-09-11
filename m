Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA03C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DFF10F6F2;
	Fri, 11 Sep 2026 20:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="34sIGnmF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F3310E56B;
 Fri, 11 Sep 2026 20:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS3uIz1JsrziVMRjPN2R8vJNcbOZEHzYyY6ehV37bSYPp10Xu9Ksact9ZsHAsQShS02YY21p/8CCZgouuJ9MAN82IxyhFE9PfAwi/7b6YHTrsUcaPz1XIefkMKrwaf2PvcCbUhQO3lBgzv/f/P6551fk2NNzxI730bjmcPqTcYqV+IeCy4O7/+BmFnpHaiykjYny9kIwZLfozbh24ogy2bRJjOlGMvCYBYJ7T9L7be9PegddCmGEMoPb3HDaNJGKUeEdxzHakTha1bUw+3cMe9qXKL+frQdTB8+j5MDzyVPnwADOPtU9qVMW9wtYPKKVvXds59YQK9VrHQrTpED2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXxqLR4c2ImOCgEMjntylrnwrMjq5DmOtvU+Z/gNuJM=;
 b=qqHAYTROROzaA3EpBJUU6VJ6wGnDMnpi9jPpI9gLTz52YcQqPev49eLA8qDdjT3JhiTolHatCv+FUJ97QnlZBN/ULnqZlai3mgYzQcDkpjXO+cJp3/ix1Gyrt4eFnr2omAj+zY4POLJwEHDJOpzgJpEIeaC2EZueQ82ptShU+NuHm6iNWRSydc6rQ9sIt918W5YeXv1tp8JWMIHaW3r/AxJPa5Vc9SXHJYMbpzk+4mjw6MaiYYdBgc+OsGlPC44ep3HzVMXanMXLBkiQpBgddANLJC73/V5cOxWDbjmNTIfWNUYGDbiFo/toCsT25FOxYSgtZbKpjAPrYC8oR1/dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXxqLR4c2ImOCgEMjntylrnwrMjq5DmOtvU+Z/gNuJM=;
 b=34sIGnmFusMO6CgYna5PHAou6e0KqUydzGH+0j5h/wiBvhRlADUQQx0AskXk5mo0P5prJDviFui+R3lQv3pE7f6tM3BOMO+wME5jLVB2/EGOuOF237pgAg5l6vsR9P0kV+7YUxJISTtvjRsl+FELi+oXNdN2gt7NV7BlOyoFpNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA3PR12MB208015.namprd12.prod.outlook.com (2603:10b6:806:517::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 20:50:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:50:58 +0000
Message-ID: <0819d227-083e-4ce1-b376-81e5941404f2@amd.com>
Date: Fri, 11 Sep 2026 14:50:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
To: Albert Esteve <aesteve@redhat.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:303:16d::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA3PR12MB208015:EE_
X-MS-Office365-Filtering-Correlation-Id: 618414cc-02a8-47aa-bccd-08df10466190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|56012099006|10067099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info: ICzMOX023LjSJ3WNIlp2gIHU52yRsrA9IyKS8X8xzcISxl+DjHLdrDQueYWR5tI4uskv42Z0PUGyPcHpH4B0CWaL+FTX3tESxaQQOTeyif8H/mTvvEgPn8t0IKItpBHgJH/PX/JSnXGckuM/xmkU0WGH7hlcgAudUGELiP7uHZ61rxBNWyWld2gUNOrlaHmXeOVGYK3mAOHkUnWJl+1MO51k1yx3BqKKTNotE+z8eIl4bIiaxgoOoDajTpx4gF1iaG8grZdN8DYsxYoMekr1WBqpgkBIAqhQ5W3L64cCVQC/L9VOKCv9Jxw0EQ9se7VmpAfTY+34ytuoufO9XIHfhAphGN2Ed7Fc8r4MKVLlV76OdPF3EOv5AZtRfsZjplPMijs90eYqRIYp8w5DLA+tf/PlaCXDJqXERzq7Rmlpe1FOffNY4H4tob+ZV1h9aAT/shQDLnHrUVa8b928MV1dO1rpsqaQZbi1edH80cDp7NJTziT1g07tJHsLpdpTz34gwBoYa6wcdMZ0nV9OJMznu7y8BhUO13wKe/zJlLR6BoEFsgJ32qCYw7K64LqDZDSf61Ql4SxVv7zKScyifezopfEXXh84oes0YfvrOo9LH/e4RcuGE9NhXUMrovRyUJCba+2rxL16DQq9MwQ2Xn4K8ef2vw4n6E4y8NIHOOjnTq+SsxZIg8hI5yXffRb2f/ek+SHbYlUlOi/RKfKWKvhORw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(921020)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJvamR3WjFmS2RCTWcrWXVSSkZvZnVTRXMvR1pyMm1KOStObnBhMGJqUzNW?=
 =?utf-8?B?MUMzOTFiV3BzSHFEN3Zhck80YndQZEVuaTA0U2dlZEdUZHM5UnZIL3JkL3pX?=
 =?utf-8?B?eTJuck84eklrbDJ4TE0xQWlNbm45TzVoSDdOdHc3OENQc3cvanhRU1E5b2tX?=
 =?utf-8?B?d3dHYXRmbW84ZmFzMmYyWXEzdnczaG1MRDFvVGFYWUFhc1BXTWNpOU9Td2xz?=
 =?utf-8?B?QUVZNlhiaE1JS0o3aDFOVmp1STJmTTdXWVBPM1JXL1psWTU2cnpGSkcvTUJQ?=
 =?utf-8?B?RzZZM2FYK1kwcnZaaUdQSzk5NlhyWGNOU2xRSkhIcU9yVmFTZzUyRGNPVEZy?=
 =?utf-8?B?YitnRVh2T2JLWmgwbnd5VmtjZTJvZjdtK2U5dW1tcWdWcWllUThnWmpYenlw?=
 =?utf-8?B?eThvK05rbFdSQi9SSnI1am5UQ2JjSG9jWWNZdlpEcjB5WGdWNU1Pc3I4QTh6?=
 =?utf-8?B?VlVHVHU5c2kxQmR2UUROWDZGNjRQRE5iTWIweUJkdzEzaWJIMm9ZS1RsV1Zj?=
 =?utf-8?B?TkdhVU9CZThUQnlNQVBHRTl3cFZnT2kzZE42TUp6bmxjY3g4ckFRdHlhUWhL?=
 =?utf-8?B?QWdoTmZMdkQ1N2llcERCZ1FqRDNsTytWU2Nma2hVQ0FIZmxLRVVhR3FUVDAz?=
 =?utf-8?B?MTJzTzlRWkxUZ1VoY1VCUzlHVXVQNm5ndTIwY1lrcVlwazJtK1Bid0hlRjFi?=
 =?utf-8?B?bVlKbUpKYmdpM0hBUUhtemhmTWhncEh2Y3ByeHFDMWVhS2NSMDB3WU41Nmt1?=
 =?utf-8?B?U2hnRHdtbC9XWWRDS2plR3dLZUM0WEVGU0VuZ1pnWFVUa1VMQlZtY2lKa2lk?=
 =?utf-8?B?OWRDWSt1UlVmV3FKZGtYVStraFAwc2xmbHhRb0diT1RLQ0szcExJbzQvNFc4?=
 =?utf-8?B?ekk3QUEvWjMyaFNnT2o0aEJuNnltZVVJTzNYd09hUnZGa2t3bE9BYlAzRThH?=
 =?utf-8?B?M0l3SFlhazg3dEJ5V3BUMy96WFF2YXEreHFSSXM5RVROcGtnOVZyY1p5WDBE?=
 =?utf-8?B?V2QzbHRYV2k2YmRsbVNTako1VTBsYXdRc1dudVJKYWMyd001Q2RUTCtPNHdm?=
 =?utf-8?B?aVl6N1RHZURQeHNUVzVzN2pTMFMreWVzeHJoZlFQUWNlTHJWc2lBUGxTUmZK?=
 =?utf-8?B?WkNybVlIMlF5cFhPbUtvQ25KdWRaN0hYMTlXZi9vNlR0SS9Mc2ZacUtSenhi?=
 =?utf-8?B?cnRmUzBHd000N2NFR1ovR0ZtWFZIQmhFVytBT2ljR2MxYktmWkxKOGMyZDNr?=
 =?utf-8?B?OWVndUFxaDlZZWpqbFNMNVkrM1RWZ1hjSjQyMWVUVmk0U2pzUGVVeEdOM25j?=
 =?utf-8?B?UnBaZ3RNVlovUUxSSzZCM3hSMHR2citoQURHUFpSNWl2WTRJWE8vWDBmL294?=
 =?utf-8?B?dUE1aEMrL1F3YVRlMzVGaDlJcndrc3hwcTZvTUlwUzA0Ui9TQ1Z4VWRIcVRJ?=
 =?utf-8?B?RGRNYUEvaUdTZ3VTTklIWWtEMDhTSE5CdllRZlF6dWNFQ3Z5clJLYUpUT1hM?=
 =?utf-8?B?dnQxTWNZdjVrVXlpd0RwcXE5TzFXU1JIWlhrMk9xbWhtb2tmbWZOc3RiR1pZ?=
 =?utf-8?B?SzhQMll1enZHbjlkZlgvZmJySjNOMDJPczZlUXBKNWJ0ejFRYzRXQnVPbm1C?=
 =?utf-8?B?MHUrNEI2QmMrT1lROFF5VG1DeHZrYllsOFlad3dOc0lZOVdmZmtIQzg4Nm9l?=
 =?utf-8?B?K0xiWHlDaFU0WVFsMi8yYnliZ0wxNkI4dCs0TjkwNllMd3RLTVhnKzFSdGNQ?=
 =?utf-8?B?WVNpNngwWkpNWE5xajFLVTgwMzZXODZxVVh2cUJzWXpYUFJWMTZ2YUw5eUYv?=
 =?utf-8?B?aUlpTXdkZ21TL2RaV1BGRDRBU01MTkQvMElxS1drZWFGQVM5UjBIOElhcEJx?=
 =?utf-8?B?QmJQcHV0QXlTVHpzcCtWUEFvL1hyTjJVdmpIcWpHN3c2eUk1Tyt0S0k5REpY?=
 =?utf-8?B?SjRLMk4yOHZhbGFNSzBNdGlMRlhCZEwvc3NqUUt0R2piOWN5WmRjRStraHhv?=
 =?utf-8?B?QmY1UjlOeWg2TjJXNnZYMTQzTnhMZ0R4eWE2ZzZoWGpNZjNjZHQ0cyt4UWtR?=
 =?utf-8?B?RUN2dFZybDZ0WHk5NmdDeUVwNEE2VS82em1rSGZwYUxmNzV6bXM1bUREYWkw?=
 =?utf-8?B?ejZUQk1GSlk0Q3hiMS9WV1lwdWlTMHdkUGxzUS8xMCtIaGpGUEowNHF6SnNv?=
 =?utf-8?B?SUpTYjlMcHhaWVd2NjZpUFd5c2NZK3ltRnRndWcrcnA3SzhWSkE3Y1VtUGFI?=
 =?utf-8?B?dGd4elAzelcreTlVajVzcXRka2pvMVJwNHNDaFlFaTVtNTJtUWxVaFZqRjlu?=
 =?utf-8?Q?OWZcVHhPR59Ntf6iGq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618414cc-02a8-47aa-bccd-08df10466190
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 20:50:58.2330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLTilAmBWDgpunm8tQfFrHQgQp+322fxdPfw1CtiMrZjBYh8wPsA9fXAXr04EQFR+3TMK2KMlGap7if8v8VayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB208015
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

Looks good to me, and I will forward this to next week's test and update 
the results.


On 9/7/26 07:28, Albert Esteve wrote:
> [Some people who received this message don't often get email from aesteve@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> series switches the KUnit helpers over to the common API.
> 
> VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> CONFIG_DRM_AMD_DC_KUNIT_TEST, so the helpers are non-static whenever
> KUnit is enabled. EXPORT_SYMBOL_IF_KUNIT places the symbols in the
> EXPORTED_FOR_KUNIT_TESTING namespace; the AMD DC test files import
> that namespace with MODULE_IMPORT_NS().
> 
> INLINE_IFN_KUNIT is dropped rather than generalized. It was only used
> on amdgpu_dm_fixpt_from_s3132(), inverted the original static inline,
> and is unnecessary for tests in another translation unit.
> 
> Tested with:
>    ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>      --kunitconfig=drivers/gpu/drm/amd/display/amdgpu_dm/tests
> 
> (CONFIG_GCOV omitted; it is not available on x86_64.)
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
> Albert Esteve (3):
>        drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
>        drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNIT
>        drm/amd/display: drop INLINE_IFN_KUNIT
> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
>   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++--------
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-----------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++------
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++--------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 146 ++++++++--------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
>   .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
>   .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
>   .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
>   .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
>   drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
>   drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
>   drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  13 +-
>   tools/lib/python/kdoc/xforms_lists.py              |   3 +-
>   51 files changed, 748 insertions(+), 728 deletions(-)
> ---
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> change-id: 20260907-visibility-unification-fd358c580447
> 
> Best regards,
> --
> Albert Esteve <aesteve@redhat.com>

