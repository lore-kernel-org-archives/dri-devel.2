Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD49CA600A
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA05E10E445;
	Wed,  7 Oct 2026 09:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BmG8SADx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F42310E419;
 Wed,  7 Oct 2026 09:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbAiIFFjBmjgKJx5tmRmIqiRQ74IGAsdnNLO22bk+PlZS7YRXTLB7FxJWz+TrgSOybjUGWWsWpNyJmRelXWolKhR9+glE2Gp9iTzMwuJLgk4IQ55Kni3yiHrZSQVs3V6roY6CuaaaGsE1mt6BTI79MX+7l0CXrjgaJfLGJqpTVrmqFFdmjPBWyXLsr20dJ8dyP4RwIsNSacRLSTR8ZGYKKdtLPEuNcqe3wPukYU6uU+dFPloSPY/jMG4n+qY/lw+MjdR4Ur+LhVofFVvZ01NXp1/4C0U+MqkUFMh5k1GUQNfcQUMtOcHTdId6VG/xBiUG+8aiWc5//rTxpo0ZJqNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMn/jEgibNMA5N2OLgR57NHG0GuK271mS0GC1DyOFqU=;
 b=hGNzlLaDJEvpQTVtQ8v1QrZoEVvMRqiRvTgmvntrATsRLJ+/wkZbktrgkU4pbV3s2B/s/2O6uY5mN+nXkyZGbaoKYLcYbf5uznsAwB5n4KgLFXtGgRSVVq6ApMQum6hEAPfjllBFizCPSMD9cKw9aeU+E0SznYOZbzkpFnQwruHPf5unDrS5GxS3Vs88B1W0yf7siFJJhV1iM6NsPpmuBBi9sIBQjfRqiSQWGn7YxBUqvvUWfv7PIvAqA8HZPcaks3Ksle5ZhdqeFvbwP+G8Ai4AkkANTa/C+7bch/e9qnXnVuqx/aEZXUX9SVPVHjY4tWSsy8Js6cItC892UAq4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMn/jEgibNMA5N2OLgR57NHG0GuK271mS0GC1DyOFqU=;
 b=BmG8SADxn0BLhtOp0W+dKRhfIYivT9yEQA4QvoS7KZnhH1afj6CRQ3nboWnY6m/hT3jOQioMDHAssMO88oWqoEZQKvvv2+il/8p+wRRvNsU2ZLqvwzp/ZJR6AuTwOeSe62775TTNL8gGVYxH/pzjv/PAJ5GHKrQJno3a0byCiNc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH9PR12MB416419.namprd12.prod.outlook.com (2603:10b6:610:354::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 09:28:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 09:28:10 +0000
Message-ID: <4bafcf67-c10e-4083-8ded-3275466f5de2@amd.com>
Date: Wed, 7 Oct 2026 11:28:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
To: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, tejas.upadhyay@intel.com,
 himal.prasad.ghimiray@intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, raag.jadav@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 pratik.bari@intel.com, Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, jinzhou.su@amd.com, cesun102@amd.com,
 lijo.lazar@amd.com, alexander.deucher@amd.com
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:208:23e::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH9PR12MB416419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e33b9d2-4e63-4af5-3957-08df24554d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|11063799006|4143699003|6133799003|10067099003|56012099006|260925021911599003|260925021311599003|260925022911599003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: V6dibzWjMsxFcPinhCU6YVzIjEZrnGyvd+6w0d/dcaojF2ghvw+XTKUWnbAyfMLtayaHehHC23B+ydnfhX+B/kPQEXy0ZNJLhh9iR7cG9aqZyUm8+yYU+20wbxN0XixKYfaDV+s9jhBU77ChyNFo9dmP0GiMfrGuliJ0bLauZmD/7uAkkpqmGiKpPrviWMj9THyYDThsvbNAfXNgIDqIrQAe1+E1esyuUWrWuqHmA2PIlJDKN2jQvXb+PY+cBZOAHkV0pkCtFRfH9ur8KCw8EKvoQlQNfyftU/U6AB/v8OPjKO/BOfS6pYvWhHPhzPCmv3jGdL6t2ihadXCaq5MTDoWRMVPZrn6v2y3++n5h9O/zlOY8rBs34N/mdVwOB8a9AEMmKHCr2KG967ZrFPM6jFocwgKr0JqJiMZ3c766j9LC68qbo+qgN0xX2T9T1I6J2EQP1sBicMrUVoQPQUi5kux1+lK+rWxD0giq1hTzyLHKL7DhZjHOtZckaSaSPWFxrcDjedjtiwU7FBhpsSn9Vh0ax5DXcXV6x7yFODn37ogy9wZIIRcKLvmPYofvElNAQt80hiHKwzBV72Opn1MiYReq5B8GaYmd7gKGGtOqAGeYAaGRFI7S7anCCR+vOZWG/VcgPsGcHNPmIs0K0Smibw0CYmH7/takvNB/fJ1w5fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5CTFlpS0h2NFVad2Z5REZvYUxyd1NERVI1aTlkbHQwL2FjVTd4S2JVdUlj?=
 =?utf-8?B?RnNmaTNYNlc4NkVsUHo2Vy8wNEl3SjhXYWdtQlY5NFo2TTU3WjlERE9FemIz?=
 =?utf-8?B?eUsvMFJIbzdPK21EQTgvM09FaEhpdUlCRWkrc1ZIdUsyQXQ2OFlkQ1M0c1Vo?=
 =?utf-8?B?ZG56bG1nYkxQcytQTVZoTUJsdVNwb3F0Yk9ReGlxVi9QQzBMdkVSYTcwTWRj?=
 =?utf-8?B?MllzbEFXSFM0a0pSMmtIcHhxemtwS29oRER3T1pFREVjeTJ3Sk1STTVGS1dx?=
 =?utf-8?B?dUx1UmpCNDcwUDVTV0VqdUx5WHJEcEcyTExucnhJN244cmozdk1DZWdvdHU1?=
 =?utf-8?B?c3FaYXdrVzlGdEFqZlJ0TlRxODVscW84WDd5RGFlL3ZjekFleEFPZ2NUVlhM?=
 =?utf-8?B?THhqcDNBRWRmeUp5WVJOK0VCSWZIbFREZlA3blVQUjgvY1RTOUN0TFVIbjVy?=
 =?utf-8?B?TXNub0dlT29aUEFTRkNEbFdCeEI1OTFJVHIvRXNRZi83MHpGelMzUUhxM1k1?=
 =?utf-8?B?NzNwZWhIdEIwMGR3bG11WERYeFdUejdxNThUNGp4aFRvL0JYTzY2c0lqczh6?=
 =?utf-8?B?ZHdWSmRJNWQzTFlzWENJUml4K0pobGJJSnpBb3A4Z2dzeWJ4ZE5tak1kbTRx?=
 =?utf-8?B?MmxuK010Z1NaMGZjMWptb1oyV0FkQnQrWHRKbU1rbVMweW5PbjFmbUtEZ0gz?=
 =?utf-8?B?RHc5eTJFTTFYcmVMUCtFd0ZBQUdvWUZ3YXJXZnVwdEJROVNnZTdNMW1yOUcr?=
 =?utf-8?B?QWh3SStvNkc3bVFvb0VmWVJic212Ry9LS1RqcURvYlB0M2I2aVh4UEdIREtJ?=
 =?utf-8?B?aU9LMWcyWXFudHdobFZESXAwQjg2WEY0ajVsclUwc0d4RkEyR3JYb0tORzNL?=
 =?utf-8?B?Tmw3bzloV3NBN0RIait5cCtxUDAweTlpUGU5eXFHL2JCMDlBQ0lraEhHZ3Ix?=
 =?utf-8?B?TFZXYjlzeEVaTnlpMHN3Vlc2WVpYckcxSmVDeW1GTDJEam81OUgvNmczdHE2?=
 =?utf-8?B?ZmxMVitVRWJicDBiM2NiVUFlRmZXMlRockhzcWRYWDYvQTljSis5VFFqTTFI?=
 =?utf-8?B?aVA3MThPWjhDYlp1TDFmNzNCUzkvU1A1NWZmNE0zTEJaUy9xemd1OFFqREVN?=
 =?utf-8?B?Y3NwM3R2NlZPT3kvRlFRajRScU9oblc5QTVFQmtMZVF1YmJPRVd6aVlzNlJz?=
 =?utf-8?B?VmZpRFIySy8wVzZ2ZUYvUVBpMndQMEpMaUNNWCt3U0xxekhlTDN0QmZtM2pp?=
 =?utf-8?B?SjE2ZGlobC8wdytEcU9EMExaOWdMSDl4ZFVpYkpFQ0lUWi9scjhaU0g4U2l0?=
 =?utf-8?B?VlI5bWFOT2MyQ2VCelhUWHAvLzJqNVlUZDkybGlEOTAvL3ZLd2o4RU5HK0o4?=
 =?utf-8?B?ODMrM09EUjg1MlRlaExmeUpIM0xYTUl3SHJLdk95eCtSWmFyNkVxejZyQzlz?=
 =?utf-8?B?REUrNnRnZ0NWYmlOcVdkcmtrV3NZc3Z2MmNrd3pWM2p5ZkFjWUJESmRIQ1NC?=
 =?utf-8?B?TlJHRjFuU2wxdjJVOXh2eTJROFQxc2lKTE1uc01uYXpNeUgweTR1L21NSy8y?=
 =?utf-8?B?czdUZFdGK1FaRHhrWTRiMHJRWmNyQmlQVjR3V0xxMUZISHhLTFNZWmpRU3da?=
 =?utf-8?B?cGZ2RkxvZ1ZqZHJOOE1zUzdOUXhNcytpcUlPblNzOW02MXc3dTFXdENGdEM5?=
 =?utf-8?B?V3N2cnJiNzJoQzN0ZnV3MGw5NGp3Q3JWYVE1RnFSK3pidDh6OVY1VCtyTG1U?=
 =?utf-8?B?QmRrMTdWSVFBdk5ZVnhWdzZta3RIaDJ3YUNGeGhINkVrNXVzanhza3FoNVFI?=
 =?utf-8?B?cmpQVVhUUnQwMGdmZjhicnVSWmlxM29JK1Vwek9hc1FlQUliL1lJY2o3OC9J?=
 =?utf-8?B?S3FsSERtV3VsOTRWTU1jdDBlbHVBUnZmQWxTTmNzTmFSK1E1YkxrY0tzR3F5?=
 =?utf-8?B?dFBxRElvNWgrSzI4REYxRkxTcEVPdHZzcW14Tlp5NmlxZ2tHTXZGNTNkOGd1?=
 =?utf-8?B?OVNGQVJGRGkwOFNrbkNaU0pHSEFGcHM1RDlUYTFkNEJDdi84L0NXWGQ3ZjFG?=
 =?utf-8?B?R1MyTjRzbXI3VXB4STFZUVQwc3I3V2krcHdyNXRZTmdOQm9BQ3FsTHJEQ3Qw?=
 =?utf-8?B?NVpQa0NUYnlDZnNuTFhPMGlnRHBpekFKeUlLd1ZZa3NsemdtRUx3cm9od2FM?=
 =?utf-8?B?T2MrdVZ1bmdLWVdKZE9aM09Ga2RNL05MQzJBb1VSQU9jYkE0WisreTlDUVhE?=
 =?utf-8?B?cXZkc1Jna2dKaTV3ODVYbThCeDkrS2NEWEhubFRaU0JyQWUxbUVGZkVzQUxP?=
 =?utf-8?Q?HTBJGDV9rYlEh2yoy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e33b9d2-4e63-4af5-3957-08df24554d8e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:28:10.4741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVjzJQtlQ2+PJ3ZW07FW+8XyxUH08PwB/l/r82lT6tytMab05v1OaWz98JKmmNcJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB416419
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

On 10/7/26 10:03, Aravind Iddamsetty wrote:
> The memory page offlining support tracks bad VRAM pages and currently
> only exposes them through debugfs (vram_bad_pages), which is not a
> stable ABI. Add a proper userspace interface using the drm-ras
> generic netlink family.

Oh, why in the world are you using netlink for that?

In almost all cases (except maybe udev) using netlink has proven to be a bad idea.

Why aren't RAS errors just exposed through sysfs and/or udev?

Regards,
Christian.

> 
> Introduce a new node type DRM_RAS_NODE_TYPE_RETIRED_RESOURCES which
> enumerates hardware resources that have been permanently taken out of
> service. Each node reports a single resource type, identified by its
> node-name, so the resource type is implied by the node rather than
> carried per entry. The per-entry payload stays extensible: each entry
> carries a single type-specific nested attribute, so future resource
> types can be added without touching existing consumers. VRAM pages are
> the first supported type, reported via the vram-page nest as
> {address, size, status} where status is one of retired/pending/failed.
> 
> A single operation is added on the node:
>  - GET_RETIRED_RESOURCES: dump the resources retired on the node. The
>    dump opens with a leading capacity summary entry (max-pages
>    inside the vram-page nest, i.e. the maximum number of pages that
>    can be offlined, with no address/size/status), followed by one
>    entry per retired resource. Userspace derives the retired/queued
>    counts by counting entries.
> 
> The netlink interface is described by the YAML spec
> Documentation/netlink/specs/drm_ras.yaml. The following files are
> generated from that spec with tools/net/ynl/ynl-regen.sh and must not
> be edited by hand:
>  - include/uapi/drm/drm_ras.h        (uapi attribute/command enums)
>  - drivers/gpu/drm/drm_ras_nl.c      (generated policy and op table)
>  - drivers/gpu/drm/drm_ras_nl.h      (generated declarations)
> 
> Eg:
> $ sudo ./tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/drm_ras.yaml \
>      --dump list-nodes
> 
> [{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name':'correctable-errors',
>  'node-type': 'error-counter'},
>  {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name':'uncorrectable-errors
> ', 'node-type': 'error-counter'},
>  {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name':'vram-retired-pages',
>  'node-type': 'retired-resources'}]
> 
> $ sudo ./tools/net/ynl/pyynl/cli.py --spec \
> Documentation/netlink/specs/drm_ras.yaml  --dump  get-retired-resources \
> --json '{"node-id": 2}'
> 
> [{'node-id': 2, 'vram-page': {'max-pages': 100}},
>  {'node-id': 2, 'vram-page': {'address': 12807041024, 'size': 4096,
>  'status': 'retired'}},
>  {'node-id': 2, 'vram-page': {'address': 12809400320, 'size': 4096,
>  'status': 'retired'}}]
> 
> The first entry is the capacity summary (max-pages); subsequent entries
> are the retired pages.
> 
> v2:
>  - Drop the per-entry resource-type discriminator attribute; the type is
>    now implied by the node (node-name), which reports a single type.
>  - Fold all VRAM-page fields, including the retirement status, into the
>    vram-page nested attribute; the top-level entry is just
>    {node-id, vram-page}. (Rodrigo)
>  - Drop the separate GET_RETIRED_RESOURCES_INFO operation. The capacity
>    (max-pages) is now emitted as a leading summary entry inside
>    GET_RETIRED_RESOURCES (max-pages in the vram-page nest, no status);
>    offlined/queued counts are derived by counting entries.
> 
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Riana Tauro <riana.tauro@intel.com>
> Cc: Raag Jadav <raag.jadav@intel.com>
> Cc: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>
> Cc: Ashwin Kumar Kulkarni <ashwin.kumar.kulkarni@intel.com>
> Cc: Pratik Bari <pratik.bari@intel.com>
> 
> Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> Assisted-by: Copilot:claude-opus-4.8
> ---
>  Documentation/netlink/specs/drm_ras.yaml |  91 +++++++++++-
>  drivers/gpu/drm/drm_ras.c                | 174 ++++++++++++++++++++++-
>  drivers/gpu/drm/drm_ras_nl.c             |  12 ++
>  drivers/gpu/drm/drm_ras_nl.h             |   2 +
>  drivers/gpu/drm/xe/xe_drm_ras.c          |  77 ++++++++++
>  drivers/gpu/drm/xe/xe_drm_ras_types.h    |   3 +
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c     | 119 ++++++++++++++++
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.h     |   3 +
>  include/drm/drm_ras.h                    |  74 ++++++++++
>  include/uapi/drm/drm_ras.h               |  48 ++++++-
>  10 files changed, 592 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index 4c2ac9a1ba3f..42ab1cceaea7 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -16,11 +16,34 @@ definitions:
>      type: enum
>      name: node-type
>      value-start: 1
> -    entries: [error-counter]
> +    entries: [error-counter, retired-resources]
>      doc: >-
> -         Type of the node. Currently, only error-counter nodes are
> -         supported, which expose reliability counters for a hardware/software
> -         component.
> +         Type of the node.
> +         error-counter nodes expose reliability counters for a
> +         hardware/software component. retired-resources nodes enumerate
> +         hardware resources (e.g. VRAM pages) that have been permanently
> +         taken out of service.
> +  -
> +    type: enum
> +    name: retired-resource-status
> +    value-start: 0
> +    entries: [retired, pending, failed]
> +    doc: >-
> +         Status of a retired resource entry. retired means the resource is
> +         permanently reserved and out of service; pending means retirement is
> +         queued but the reservation is not yet complete; failed means the
> +         reservation failed and the resource may still be in use.
> +  -
> +    type: enum
> +    name: retired-resource-type
> +    value-start: 1
> +    entries: [vram-page]
> +    doc: >-
> +         Type of a retired resource entry. The type selects which type-specific
> +         nested attribute is present. New hardware resource types can be added
> +         here, each carrying its own nested attribute set, without affecting
> +         existing types. vram-page describes a VRAM page by device address and
> +         size.
>  
>  attribute-sets:
>    -
> @@ -100,6 +123,45 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: retired-resource-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: Node ID targeted by this retired resource operation.
> +      -
> +        name: vram-page
> +        type: nest
> +        nested-attributes: vram-page-attrs
> +        doc: >-
> +             Type-specific payload. The resource type is identified by the
> +             node (its node-name); each node reports a single resource type.
> +  -
> +    name: vram-page-attrs
> +    attributes:
> +      -
> +        name: address
> +        type: u64
> +        doc: Device address of the retired VRAM page (e.g. DPA).
> +      -
> +        name: size
> +        type: u64
> +        doc: Size of the retired VRAM page in bytes.
> +      -
> +        name: max-pages
> +        type: u32
> +        doc: >-
> +             Maximum VRAM pages that can be retired. Present only in the
> +             leading summary entry of the dump (no address/size/status).
> +      -
> +        name: status
> +        type: u32
> +        doc: Retirement status of the retired VRAM page.
> +        enum: retired-resource-status
> +      -
> +        name: pad
> +        type: pad
>  
>  operations:
>    list:
> @@ -199,6 +261,27 @@ operations:
>              - node-id
>              - error-id
>              - error-threshold
> +    -
> +      name: get-retired-resources
> +      doc: >-
> +           Enumerate the resources (e.g. VRAM pages) that a retired-resources
> +           node has taken out of service. The dump begins with a leading
> +           capacity summary entry (max-pages, with no address/size/status),
> +           followed by one entry per retired resource (address, size and a
> +           retirement status). The resource type is identified by the node
> +           (its node-name); each node reports a single type. User space
> +           derives the retired/queued counts by counting entries, and must
> +           obtain the node ID from list-nodes first.
> +      attribute-set: retired-resource-attrs
> +      flags: [admin-perm]
> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes:
> +            - node-id
> +            - vram-page
>  
>  mcast-groups:
>    list:
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b099eb67836e..46ee897a13c9 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -63,7 +63,6 @@
>   * Node type:
>   *
>   * - ERROR_COUNTER:
> - *     + Currently, only error counters are supported.
>   *     + The driver must implement the query_error_counter() callback to provide
>   *       the name and the value of the error counter.
>   *     + The driver must provide a error_counter_range.last value informing the
> @@ -81,6 +80,13 @@
>   *       that are raised by the hardware.
>   *     + The driver is responsible for error threshold bounds checking.
>   *
> + * - RETIRED_RESOURCES:
> + *     + Enumerates hardware resources (e.g. VRAM pages) permanently taken out
> + *       of service.
> + *     + The driver must implement the query_retired_resource() callback, which
> + *       is called with an incrementing index and returns -ENOENT once the last
> + *       entry has been reported.
> + *
>   * Netlink handlers:
>   *
>   * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> @@ -95,6 +101,9 @@
>   *   operation, fetching the error threshold of a specific counter.
>   * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
>   *   operation, setting the error threshold of a specific counter.
> + * - drm_ras_nl_get_retired_resources_dumpit(): Implements the
> + *   GET_RETIRED_RESOURCES dumpit operation, enumerating retired resources of a
> + *   specific node.
>   */
>  
>  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -105,6 +114,10 @@ static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>  struct drm_ras_ctx {
>  	/* Which xarray id to restart the dump from */
>  	unsigned long restart;
> +	/* Ordering-key cursor for retired-resource dumps (inclusive lower bound) */
> +	u64 cursor;
> +	/* Whether the leading retired-resource summary has been emitted */
> +	bool summary_sent;
>  };
>  
>  /**
> @@ -564,6 +577,148 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  	return node->clear_error_counter(node, error_id);
>  }
>  
> +static int msg_put_retired_resource(struct sk_buff *skb, u32 node_id,
> +				    const struct drm_ras_retired_resource *res)
> +{
> +	struct nlattr *nest;
> +
> +	if (nla_put_u32(skb, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID, node_id))
> +		return -EMSGSIZE;
> +
> +	/* Type is implied by the node (its node_name); it selects the nest. */
> +	switch (res->type) {
> +	case DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE:
> +		nest = nla_nest_start(skb,
> +				      DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE);
> +		if (!nest)
> +			return -EMSGSIZE;
> +
> +		if (res->is_summary) {
> +			/* Leading capacity summary: max retirable pages. */
> +			if (nla_put_u32(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_MAX_PAGES,
> +					res->vram_page.max_pages)) {
> +				nla_nest_cancel(skb, nest);
> +				return -EMSGSIZE;
> +			}
> +		} else if (nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS,
> +					     res->vram_page.address,
> +					     DRM_RAS_A_VRAM_PAGE_ATTRS_PAD) ||
> +			   nla_put_u64_64bit(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
> +					     res->vram_page.size,
> +					     DRM_RAS_A_VRAM_PAGE_ATTRS_PAD) ||
> +			   nla_put_u32(skb, DRM_RAS_A_VRAM_PAGE_ATTRS_STATUS,
> +				       res->status)) {
> +			nla_nest_cancel(skb, nest);
> +			return -EMSGSIZE;
> +		}
> +
> +		nla_nest_end(skb, nest);
> +		break;
> +	default:
> +		/* Unknown type: only the common node-id is reported. */
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_ras_nl_get_retired_resources_dumpit() - Dump retired resources of a node
> + * @skb: Netlink message buffer
> + * @cb: Callback context for multi-part dumps
> + *
> + * Iterates over all retired resources of a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES
> + * node and appends their attributes to the given netlink message buffer. The
> + * dump opens with an optional leading type-specific capacity summary (e.g. the
> + * maximum retirable page count), followed by one entry per retired resource;
> + * each resource entry carries a status plus one type-specific nested attribute
> + * selected by the node's type. Uses @cb->ctx to store an ordering-key cursor
> + * so multi-part dumps resume by key rather than position, staying correct if
> + * the list changes concurrently between message parts.
> + *
> + * Return: 0 if all entries fit in @skb, number of bytes added to @skb if
> + *          the buffer filled up (requires multi-part continuation), or
> + *          a negative error code on failure.
> + */
> +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
> +					    struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> +	struct drm_ras_retired_resource res;
> +	struct drm_ras_node *node;
> +	struct nlattr *hdr;
> +	u32 node_id;
> +	u64 cursor;
> +	int ret = 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID]);
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || node->type != DRM_RAS_NODE_TYPE_RETIRED_RESOURCES ||
> +	    !node->query_retired_resource)
> +		return -ENOENT;
> +
> +	/* Leading type-specific capacity summary (e.g. max pages), emitted once. */
> +	if (!ctx->summary_sent && node->query_retired_summary) {
> +		memset(&res, 0, sizeof(res));
> +		ret = node->query_retired_summary(node, &res);
> +		if (ret == 0) {
> +			hdr = genlmsg_iput(skb, info);
> +			if (!hdr)
> +				return -EMSGSIZE;   /* retry summary next part */
> +			ret = msg_put_retired_resource(skb, node_id, &res);
> +			if (ret) {
> +				genlmsg_cancel(skb, hdr);
> +				return ret;
> +			}
> +			genlmsg_end(skb, hdr);
> +		} else if (ret != -ENOENT) {
> +			return ret;
> +		}
> +		ctx->summary_sent = true;
> +	}
> +
> +	cursor = ctx->cursor;
> +	for (;;) {
> +		memset(&res, 0, sizeof(res));
> +		ret = node->query_retired_resource(node, cursor, &res);
> +		/* -ENOENT marks the end of the list. */
> +		if (ret == -ENOENT) {
> +			ret = 0;
> +			break;
> +		}
> +		if (ret)
> +			return ret;
> +
> +		hdr = genlmsg_iput(skb, info);
> +		if (!hdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = msg_put_retired_resource(skb, node_id, &res);
> +		if (ret) {
> +			genlmsg_cancel(skb, hdr);
> +			break;
> +		}
> +
> +		genlmsg_end(skb, hdr);
> +		/* Advance past this entry; keys are unique. */
> +		cursor = res.key + 1;
> +	}
> +
> +	/* On buffer-full the current entry was not emitted; resume at it. */
> +	if (ret == -EMSGSIZE)
> +		ctx->cursor = cursor;
> +
> +	return ret;
> +}
> +
>  /**
>   * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
>   * @skb: Netlink message buffer
> @@ -631,15 +786,24 @@ int drm_ras_node_register(struct drm_ras_node *node)
>  	if (!node->device_name || !node->node_name)
>  		return -EINVAL;
>  
> -	/* Currently, only Error Counter Endpoints are supported */
> -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> -		return -EINVAL;
> -
>  	/* Mandatory entries for Error Counter Node */
>  	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
>  	    (!node->error_counter_range.last || !node->query_error_counter))
>  		return -EINVAL;
>  
> +	/* Mandatory entries for Retired Resources Node */
> +	if (node->type == DRM_RAS_NODE_TYPE_RETIRED_RESOURCES &&
> +	    !node->query_retired_resource)
> +		return -EINVAL;
> +
> +	switch (node->type) {
> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> +	case DRM_RAS_NODE_TYPE_RETIRED_RESOURCES:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL(drm_ras_node_register);
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index c9f5e0ceb3b5..2f23f5681fa4 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -41,6 +41,11 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
>  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
>  };
>  
> +/* DRM_RAS_CMD_GET_RETIRED_RESOURCES - dump */
> +static const struct nla_policy drm_ras_get_retired_resources_nl_policy[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID + 1] = {
> +	[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +};
> +
>  /* Ops table for drm_ras */
>  static const struct genl_split_ops drm_ras_nl_ops[] = {
>  	{
> @@ -83,6 +88,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_RESOURCES,
> +		.dumpit		= drm_ras_nl_get_retired_resources_dumpit,
> +		.policy		= drm_ras_get_retired_resources_nl_policy,
> +		.maxattr	= DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +	},
>  };
>  
>  static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 9aef097ea10f..96b0fe017ea8 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -24,6 +24,8 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>  					struct genl_info *info);
>  int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
>  					struct genl_info *info);
> +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
> +					    struct netlink_callback *cb);
>  
>  enum {
>  	DRM_RAS_NLGRP_ERROR_REPORT,
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index 7f3695707611..fba58e9eb7e0 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -12,6 +12,7 @@
>  #include "xe_device_types.h"
>  #include "xe_drm_ras.h"
>  #include "xe_ras.h"
> +#include "xe_ttm_vram_mgr.h"
>  
>  static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
>  static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
> @@ -188,6 +189,75 @@ static void cleanup_node(struct drm_device *drm, void *node)
>  	cleanup_node_param(node);
>  }
>  
> +static int query_retired_resource(struct drm_ras_node *node, u64 cursor,
> +				  struct drm_ras_retired_resource *res)
> +{
> +	struct xe_device *xe = node->priv;
> +	int ret;
> +
> +	ret = xe_ttm_vram_get_retired_page(xe, cursor, &res->vram_page.address,
> +					   &res->vram_page.size, &res->status);
> +	if (ret)
> +		return ret;
> +
> +	res->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
> +	res->key = res->vram_page.address;
> +
> +	return 0;
> +}
> +
> +static int query_retired_summary(struct drm_ras_node *node,
> +				 struct drm_ras_retired_resource *res)
> +{
> +	struct xe_device *xe = node->priv;
> +
> +	res->type = DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE;
> +	res->is_summary = 1;
> +	res->vram_page.max_pages = xe_ttm_vram_get_max_bad_pages(xe);
> +
> +	return 0;
> +}
> +
> +static int register_retired_node(struct xe_device *xe)
> +{
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct xe_drm_ras *ras = &xe->ras;
> +	struct drm_ras_node *node;
> +	const char *device_name;
> +	int ret;
> +
> +	/* Retired VRAM pages are only tracked on platforms with page offline */
> +	if (xe->info.platform != XE_CRESCENTISLAND)
> +		return 0;
> +
> +	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
> +				pci_domain_nr(pdev->bus), pdev->bus->number,
> +				PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +	if (!device_name)
> +		return -ENOMEM;
> +
> +	node->device_name = device_name;
> +	node->node_name = "vram-retired-pages";
> +	node->type = DRM_RAS_NODE_TYPE_RETIRED_RESOURCES;
> +	node->query_retired_resource = query_retired_resource;
> +	node->query_retired_summary = query_retired_summary;
> +	node->priv = xe;
> +
> +	ret = drm_ras_node_register(node);
> +	if (ret) {
> +		cleanup_node_param(node);
> +		return ret;
> +	}
> +
> +	ras->retired_node = node;
> +
> +	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> +}
> +
>  static int register_nodes(struct xe_device *xe)
>  {
>  	struct xe_drm_ras *ras = &xe->ras;
> @@ -279,5 +349,12 @@ int xe_drm_ras_init(struct xe_device *xe)
>  		return err;
>  	}
>  
> +	err = register_retired_node(xe);
> +	if (err) {
> +		drm_err(&xe->drm, "Failed to register DRM RAS retired node (%pe)\n",
> +			ERR_PTR(err));
> +		return err;
> +	}
> +
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras_types.h b/drivers/gpu/drm/xe/xe_drm_ras_types.h
> index 0be218ba2db7..186024640f87 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_drm_ras_types.h
> @@ -41,6 +41,9 @@ struct xe_drm_ras {
>  	/** @node: DRM RAS node */
>  	struct drm_ras_node *node;
>  
> +	/** @retired_node: DRM RAS retired-resources node for VRAM bad pages */
> +	struct drm_ras_node *retired_node;
> +
>  	/** @info: info array for all types of errors */
>  	struct xe_drm_ras_counter *info[DRM_XE_RAS_ERR_SEV_MAX];
>  
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> index 9a514d983e90..b56b543a56a2 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -15,6 +15,8 @@
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/ttm/ttm_range_manager.h>
>  
> +#include <uapi/drm/drm_ras.h>
> +
>  #include "regs/xe_regs.h"
>  #include "xe_bo.h"
>  #include "xe_configfs.h"
> @@ -624,6 +626,123 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
>  	return avail;
>  }
>  
> +/**
> + * xe_ttm_vram_get_retired_page - Fetch the next retired VRAM page by address
> + * @xe: xe device instance
> + * @min_addr: inclusive lower bound; return the page with the smallest DPA >=
> + *            this value
> + * @addr: output, device physical address (DPA) of the page
> + * @size: output, size of the page in bytes
> + * @status: output, retirement status (enum drm_ras_retired_resource_status)
> + *
> + * Scans the offlined and queued page lists across all tiles and returns the
> + * entry with the smallest DPA that is >= @min_addr. Because retired pages have
> + * unique addresses, iterating with @min_addr = previous_addr + 1 walks every
> + * entry in a stable address order, which is robust against concurrent
> + * insertion or removal between calls. Intended to back the drm-ras
> + * retired-resources node enumeration.
> + *
> + * Return: 0 on success, -ENOENT when no page has a DPA >= @min_addr.
> + */
> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
> +				 u64 *addr, u64 *size, u32 *status)
> +{
> +	struct xe_ttm_vram_offline_resource *pos;
> +	struct ttm_resource_manager *man;
> +	struct gpu_buddy_block *block;
> +	struct xe_ttm_vram_mgr *mgr;
> +	u64 best_addr = 0, best_size = 0;
> +	struct xe_tile *tile;
> +	u32 best_status = 0;
> +	bool found = false;
> +	u8 id;
> +
> +	for_each_tile(tile, xe, id) {
> +		struct xe_vram_region *vr = tile->mem.vram;
> +		u64 a, s;
> +
> +		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> +		if (!man || !vr)
> +			continue;
> +		mgr = to_xe_ttm_vram_mgr(man);
> +
> +		rcu_read_lock();
> +
> +		list_for_each_entry_rcu(pos, &mgr->offlined_pages, offlined_link) {
> +			block = list_first_entry_or_null(&pos->blocks,
> +							 struct gpu_buddy_block, link);
> +			if (block) {
> +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
> +				s = gpu_buddy_block_size(&mgr->mm, block);
> +			} else {
> +				a = pos->addr + vr->dpa_base;
> +				s = SZ_4K;
> +			}
> +
> +			if (a >= min_addr && (!found || a < best_addr)) {
> +				best_addr = a;
> +				best_size = s;
> +				best_status = DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED;
> +				found = true;
> +			}
> +		}
> +
> +		list_for_each_entry_rcu(pos, &mgr->queued_pages, queued_link) {
> +			block = list_first_entry_or_null(&pos->blocks,
> +							 struct gpu_buddy_block, link);
> +			if (block) {
> +				a = gpu_buddy_block_offset(block) + vr->dpa_base;
> +				s = gpu_buddy_block_size(&mgr->mm, block);
> +			} else {
> +				a = pos->addr + vr->dpa_base;
> +				s = SZ_4K;
> +			}
> +
> +			if (a >= min_addr && (!found || a < best_addr)) {
> +				best_addr = a;
> +				best_size = s;
> +				best_status = pos->status == XE_PAGE_RESERVE_FAIL ?
> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED :
> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING;
> +				found = true;
> +			}
> +		}
> +
> +		rcu_read_unlock();
> +	}
> +
> +	if (!found)
> +		return -ENOENT;
> +
> +	*addr = best_addr;
> +	*size = best_size;
> +	*status = best_status;
> +
> +	return 0;
> +}
> +
> +/**
> + * xe_ttm_vram_get_max_bad_pages - Fetch the FW-provided max offline page count
> + * @xe: xe device instance
> + *
> + * Returns the static maximum number of VRAM pages that can be offlined, as
> + * provided by FW at init. Intended to back the drm-ras retired-resources
> + * capacity summary. Read from the root (VRAM0) manager; the value is a static
> + * device-wide count.
> + *
> + * Return: max offline page count, or 0 if VRAM is not present.
> + */
> +u32 xe_ttm_vram_get_max_bad_pages(struct xe_device *xe)
> +{
> +	struct ttm_resource_manager *man;
> +
> +	man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0);
> +	if (!man)
> +		return 0;
> +
> +	return to_xe_ttm_vram_mgr(man)->max_pages;
> +}
> +
>  static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
>  {
>  	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> index d77f067d197b..70fae023d6a3 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> @@ -33,6 +33,9 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
>  			  u64 *used, u64 *used_visible);
>  int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
>  int xe_ttm_vram_inject_fault(struct xe_device *xe);
> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
> +				 u64 *addr, u64 *size, u32 *status);
> +u32 xe_ttm_vram_get_max_bad_pages(struct xe_device *xe);
>  
>  static inline struct xe_ttm_vram_mgr_resource *
>  to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 1765a3130b09..38953f8f3012 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -10,6 +10,42 @@
>  
>  #include <uapi/drm/drm_ras.h>
>  
> +/**
> + * struct drm_ras_retired_resource - A single retired resource entry
> + *
> + * Describes one hardware resource that has been taken out of service and is
> + * reported by a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. @type selects which
> + * member of the anonymous union is valid, allowing new hardware resource types
> + * to be added without changing the common fields. When @is_summary is set the
> + * entry is a leading, type-specific capacity summary (e.g. max retirable
> + * pages) rather than an individual retired resource.
> + */
> +struct drm_ras_retired_resource {
> +	/** @type: Resource type (enum drm_ras_retired_resource_type). */
> +	__u32 type;
> +	/** @status: Retirement status (enum drm_ras_retired_resource_status). */
> +	__u32 status;
> +	/**
> +	 * @key: Opaque, driver-assigned ordering key for this entry. drm-ras
> +	 * uses it only to advance the dump cursor; entries must be enumerable
> +	 * in strictly increasing @key order and keys must be unique.
> +	 */
> +	__u64 key;
> +	/** @is_summary: entry reports type capacity, not a retired resource. */
> +	__u8 is_summary;
> +	union {
> +		/** @vram_page: Valid when @type is VRAM_PAGE. */
> +		struct {
> +			/** @vram_page.address: Device address (e.g. DPA). */
> +			__u64 address;
> +			/** @vram_page.size: Size in bytes. */
> +			__u64 size;
> +			/** @vram_page.max_pages: max retirable pages; summary only. */
> +			__u32 max_pages;
> +		} vram_page;
> +	};
> +};
> +
>  /**
>   * struct drm_ras_node - A DRM RAS Node
>   */
> @@ -100,6 +136,44 @@ struct drm_ras_node {
>  	 */
>  	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
>  
> +	/**
> +	 * @query_retired_resource:
> +	 *
> +	 * This callback is used by drm-ras to enumerate retired resources of a
> +	 * %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node. It is called with @cursor
> +	 * and must return the next entry whose ordering key is greater than or
> +	 * equal to @cursor, setting @res->key to that entry's key. drm-ras
> +	 * resumes multi-part dumps from the returned key, so enumeration stays
> +	 * correct across concurrent insertion or removal.
> +	 *
> +	 * The @query_retired_resource is a mandatory callback for
> +	 * retired-resources nodes.
> +	 *
> +	 * Returns: 0 on success,
> +	 *          -ENOENT when no entry has a key >= @cursor, used as an
> +	 *                  indication that enumeration is complete.
> +	 *          Other negative values on errors that should terminate the
> +	 *          netlink query.
> +	 */
> +	int (*query_retired_resource)(struct drm_ras_node *node, u64 cursor,
> +				      struct drm_ras_retired_resource *res);
> +
> +	/**
> +	 * @query_retired_summary:
> +	 *
> +	 * This optional callback fills a leading, type-specific capacity summary
> +	 * for a %DRM_RAS_NODE_TYPE_RETIRED_RESOURCES node (e.g. the maximum
> +	 * number of retirable pages). drm-ras emits it as the first entry of the
> +	 * retired-resources dump. The driver must set @res->is_summary, @res->type
> +	 * and the type-specific summary fields (e.g. vram_page.max_pages).
> +	 *
> +	 * Returns: 0 on success,
> +	 *          -ENOENT if the node has no summary to report,
> +	 *          other negative values on errors that terminate the query.
> +	 */
> +	int (*query_retired_summary)(struct drm_ras_node *node,
> +				     struct drm_ras_retired_resource *res);
> +
>  	/** @priv: Driver private data */
>  	void *priv;
>  };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 2f832275ee6e..64a7a7feb610 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -11,11 +11,35 @@
>  #define DRM_RAS_FAMILY_VERSION	1
>  
>  /*
> - * Type of the node. Currently, only error-counter nodes are supported, which
> - * expose reliability counters for a hardware/software component.
> + * Type of the node. error-counter nodes expose reliability counters for a
> + * hardware/software component. retired-resources nodes enumerate hardware
> + * resources (e.g. VRAM pages) that have been permanently taken out of service.
>   */
>  enum drm_ras_node_type {
>  	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> +	DRM_RAS_NODE_TYPE_RETIRED_RESOURCES,
> +};
> +
> +/*
> + * Status of a retired resource entry. retired means the resource is
> + * permanently reserved and out of service; pending means retirement is queued
> + * but the reservation is not yet complete; failed means the reservation failed
> + * and the resource may still be in use.
> + */
> +enum drm_ras_retired_resource_status {
> +	DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED,
> +	DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING,
> +	DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED,
> +};
> +
> +/*
> + * Type of a retired resource entry. The type selects which type-specific
> + * nested attribute is present. New hardware resource types can be added here,
> + * each carrying its own nested attribute set, without affecting existing
> + * types. vram-page describes a VRAM page by device address and size.
> + */
> +enum drm_ras_retired_resource_type {
> +	DRM_RAS_RETIRED_RESOURCE_TYPE_VRAM_PAGE = 1,
>  };
>  
>  enum {
> @@ -51,6 +75,25 @@ enum {
>  	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>  };
>  
> +enum {
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID = 1,
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_VRAM_PAGE,
> +
> +	__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX,
> +	DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_RESOURCE_ATTRS_MAX - 1)
> +};
> +
> +enum {
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_ADDRESS = 1,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_SIZE,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_MAX_PAGES,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_STATUS,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_PAD,
> +
> +	__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX,
> +	DRM_RAS_A_VRAM_PAGE_ATTRS_MAX = (__DRM_RAS_A_VRAM_PAGE_ATTRS_MAX - 1)
> +};
> +
>  enum {
>  	DRM_RAS_CMD_LIST_NODES = 1,
>  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> @@ -58,6 +101,7 @@ enum {
>  	DRM_RAS_CMD_ERROR_EVENT,
>  	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>  	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_GET_RETIRED_RESOURCES,
>  
>  	__DRM_RAS_CMD_MAX,
>  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

