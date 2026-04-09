Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB95FF31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A97A10E304;
	Thu,  9 Apr 2026 14:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iXGbnGSq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC1B10E304
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m97X+Jq//W8Lco3Y7w743umTy6/OrUF/hk9gIJcFb9ZdO523pTHNxjoiUI3rodScgfiRkF1p7e4z52EEyUn04MznNxTiMe15oSUel1ES95wpBifBR1SZ/ets8J8eojTqGpw02TFhI1Gh9TXHyWHULbsQ09pEef6POTuSR2Wi+yJ0HepFeBwSkvzmobZxwT6OgFmgJEnuYBiBCAAE3TCI3iZzEaNtU7Z87XhVjMI1FLKFyYpjKL0Y63vIJ2OMHm4xDSzKndtGgqWLcMx9r3eO0Kg32Ei7fBrRc5O42SxyQZh/3Fn9+FTl9rW/Ci988wcmhY3IfRnDU8xnJC501VrRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqAgzUr3oXf9NhlISs9k3ibCLYy5/5NFBX1Fkr7JIMc=;
 b=Mk3NbqZ6F9bj2qIEycE07dzAKrUDev+6sr8Eu8JnPeVmNwGiUi4WBpMEOwRwDuPoVhOO+tZUsGf+3i1iBOdNh7QGW1rBf2HZoQMhFWCPEt8/Y4m7QaHv1BczET3+eHp3RWlI8KyyeMe3DuiKce/Dy8/J9kSzoWAblqOmLTmSk8dgb28h4udLKES48jiFjBHPiT8S20u9X2V6ThT4iZcsD0JNxp7xgiOc0aBzMbUH0/9ndMvDBVXXU+maJKUbwavmkbxqModnRs0ks3Teqt3sfheJv9yl3bw2keJiAnziXrMHSPwUrQgIMasaDk2wwjJvqwn2cT83T0FUjguJOgYA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqAgzUr3oXf9NhlISs9k3ibCLYy5/5NFBX1Fkr7JIMc=;
 b=iXGbnGSqqhr3ckXiV0mlctju6bbfEWVsvt2JPU50X+5/MQabbu9VHeFHWPm0QCRlZ4pxwSaUxWUzX8V9w2kG7OQZoMB065klcIR8L0kR8nWxWqz3HYaRgMc06AIYhKwkb6u6tif6Iv+qfKH04mPAiz7yHIG+XIUCDHM55XrxCcQFN5hxoR56+IVdbXlwaNNqSwv+xboC5Do2pGhp/AExUwSBNnFg+B80UrHyhyjpRmieflcJoBtDjLCePYByVwxMhfUdD4lKEEbic0tQfECMgUJJoliDfBxD1w5ZgtabRqC2TNKEKLMrb44Xfx/os7w09sWuXtjHkEiB81VYRqQBVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 14:19:56 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:19:56 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 0/3] gpu: nova-core: unload extras for Hopper/Blackwell
Date: Thu, 09 Apr 2026 23:19:38 +0900
Message-Id: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PzU7DMBCEXyXyma1sx7HjCCHeA/WwG2+oS34gT
 gJS1XfHTeGAxGEPI818M3sRiefISTTFRcy8xRSnMQv1UIj2hOMrQwxZCy21lUZ6IAPUY/v2yX0
 P69hPGCBYa6TzFXlpRU6+z9zFr536crzrtNKZ2+WG+nHM/LHmuuVuE4SJoZ2GIS5NgQ5lLYmML
 i0TV86Rdc4Gb2RQTjmvdNfZEG6ogVPCfWdTPO4zy3yq9FIfqrrWRoOC82klwjk8j1sMEQ+56Om
 /cKW0sjBOG/7+timQYLEKtS6Jlf+LOF6v39UBcaVDAQAA
X-Change-ID: 20260409-b4-blackwell-unload-d6640795b906
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TY1PR01CA0188.jpnprd01.prod.outlook.com (2603:1096:403::18)
 To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ffef5e-9fc5-4831-fc9e-08de9643133d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: IXyC3SG3RDdDc0bGyZbe1LBm1GPuy8Ln7r+IHHeevM55749mArzbexGSD1Mzm6hf4m9GV42BGOmWUZO0SV2dot/mFXmznZXCl9nYQ6XOkZXryAgk1pN09QIqKWDFPC49dAqK5gjD51MhxaRvoiu0Jv3Q+/TCaU3BjVEufhaRwCVE2HlPNIvR0Ox4DVMssbHvqiKKmGJbgUKdHdHBVtQPHm+gP7OveFAR1VKUbfj/kTyp4d3asxSQzXh4eWgRuL40Zzbl9GNsQJVi6gAdLlRXZklHXDT9hKpGtFbmmP2bd4HUmQSXLkxEFpa4pq7YG+Af848oRtGlTfiOFu/LUVy1GXprTzedyN5/cvUlv+I9+s+aAqDwc9u3qfVQ+d4ZhO2dJvG6ejFKxXfNIVDcEzvFtcMSLo2Xn7rOZyqvfK3cUT+lJoNpRsLtXYdih85z4rycfN4KMUTJygPgku4Ln7C+jDIYhGu7sm0M1/4/2ZbTSDWUzV4uHohw+Jk4DjCNdgow3vrcUjXOdrRjJ68uewTeiM2H3LdMvpZwjjJSdr4aw5BPgwqJEHCwp9Ua5UtbpRPtTgW5LMMLIrohTR0a81iZXWixfL4pAijrXP1R50sXmp7Ae9Tv7iGxhJ2GqpYn253bp1IvDNvQC/70pyDHISNL6FuJ8Qdfoqupgl8rWou5tBuCQf09VatjQ6JoMNCrESC6tKuEKi++ttwF2jP9KUeD3crsWNWhhVI2sH6r7TADx9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3hLRTV1WXhNSG1EYTJmdmk4SDNDSnpLTkY0WnErd1o2YU1wdDRRYUNWN01D?=
 =?utf-8?B?eFhLclE3QXVsNE9kUU0ySSs3b2M0dmJWRC9Eay9TZm1mN2d5NForbFB5UDc1?=
 =?utf-8?B?cEF2Z0lzSzdyUHl6anoyTnJ0a1JBZ1N4TjRGRXZEWkJpdkgzRVI3Sm50b0pN?=
 =?utf-8?B?SERKa3ZoNVN2RUJIVFc5T1NSanBWRUNkaFdQdWp6RzhSOTQwRE4zYzhGS25E?=
 =?utf-8?B?Vzh5ZDJ6cXZ1UXhvWVErQnErYUxqaW45Q1ZNQ2Q1NDVFYi85M3dmZm1LRlRY?=
 =?utf-8?B?dTNPUXJqY0FuMWo4YzhZV09JeGE3bUZtbVNjNXdHd0VjYmwyR3JhcjlKOHUy?=
 =?utf-8?B?VmhnQnQ0VmZkQTNjRXk4SW14bS9kTEtpajdNeno1Zzg4Nk13ZWtmdGFmSVhk?=
 =?utf-8?B?VTAzNWVsdTdjOVRSVCsrRDM0TmtGWVllemVXcFlCUm1ERTl5ZzJod1FoNmdO?=
 =?utf-8?B?M0JLUFA2YU9Za1VSMEdBSi95a1pyUEJHd3JCUmtWYjVJY1hSaEQzUEtwQk1n?=
 =?utf-8?B?dGRaTHFJekxrZmt1UTJqMEhxb3ZoV2pzQ3dlUGVKVHQ2YUcrVXNVekRhSFdP?=
 =?utf-8?B?cFo2MEU1L0JzNkxBN1AvWEltQ3FSM2hkSU01eUsvRlI3dHMrUzFTOHpPRGxp?=
 =?utf-8?B?V3ZTRzdrVld6TEptVFZrbnI5U3Z4NVAyRWpIY1k0elovYnBlU3VUeGJZV05S?=
 =?utf-8?B?bkRPVlN2dDM5eDNsVkpNUW1UTU9xWEdLUWhHTkxHbCsvWGVVM0hMK3daQ3ZL?=
 =?utf-8?B?Z2JpRy9GZTRZVERkUkhTOHB1WTlNVmZjL1FZWG1qczdFZHllQzMxdTJFSmFh?=
 =?utf-8?B?VzlucnRSd1NCUmVSdnd4MVVVWmhhc3l5czhNdk1ybUxkdkI4ajhRQ1NENHlU?=
 =?utf-8?B?aUtGL2F4RkNlOGFDaC92TGppWHhtZE1pRzB3T0ZwL1p6b0E2cTY4azFGVHdB?=
 =?utf-8?B?a3BPY1JFaStPU1NEYnZMT1NDOVhnWnhlTFVqcU9aamc0Ni93V1drOFBRc1pW?=
 =?utf-8?B?V01jYXFQZGhEbmpEdUIvckNBNWgvNjFnczRSSUozWGtyUXdna0t1VFZyWVBj?=
 =?utf-8?B?UFRDVWM1ckxLS3NVOWYxc1dWdlVFekJESGRJS3Rsa0I4NjJQZ1FEKzBLVGF2?=
 =?utf-8?B?SkFJNzBwWUdubTFrQk9oUGdsRUtMZDJ2eGd5UlpMcXZ2Q3lrdnVJU05PaHhY?=
 =?utf-8?B?VzE3bE5uZDRsVXZRTkFiTDZ0Wi9sOHBLVEVOZm51YjluVXgyNmxiRWNpV1g1?=
 =?utf-8?B?NlpNdU4wWlgxdDlJcEdXUVNxZ294OXBKclJaMUdQVU94bWVodnFPNk5FUWNK?=
 =?utf-8?B?MDQyeFN1YndaNjNydGhvZGdwcWNCSU9yTy9FODN4RC9pVUZCODF6R2RaK0k4?=
 =?utf-8?B?c1FPYzBBRzVRcVFsMjZWQVVjR3ZaRjIvNG1WUmVxbW12S3ZTL3U1K2tFSkF3?=
 =?utf-8?B?SGtBQTFPbzhPbDJGSVRTQTRDMEkycXRZeWxESktFbnNwOXBjTzRKQUlCM2F4?=
 =?utf-8?B?eVZ4VmUxOEdDalEzUy9mckFJK2k1R2h0enBNUEpscU8wQkVqWEhIaVZVSFZO?=
 =?utf-8?B?ZU9sWkxYNnpiZlBBc1E4UzZ5amVyUFVNQ2dGUHVhUm8zeFhVYkhYNDBhUlFw?=
 =?utf-8?B?dmxkNTN5WDd6aVNKZVBrSFplYU9nb1dBME9yMjF6SUlrdWl1OXNhSG5tQk9x?=
 =?utf-8?B?cWNwSU01WUhTS1h1VGlaQkJZVkdhNjBQQlBkZFF2dlpWOWNnWW1vWDZtSG82?=
 =?utf-8?B?UzRsOUUxQWpRam40YnVYVFEwOURXRThIMEdJV3dGejN2UXBIK3YwUjhHS1pR?=
 =?utf-8?B?MERJZDJhdk00V3NuMW56aHg2OW1YQXJiRXB5K2FVL25ySDhJSGN0MVc0Z2dV?=
 =?utf-8?B?TzcyM0RxTjh5dno3S3dzdWJ3VERYOE1GZlFEWmc3bTNFYzZaUHdUWXN5TnN3?=
 =?utf-8?B?dlFBODhrVEZpWGxlUGZia2QxOFhrMGRURnpxV28yNzdkUWVMaUpQakdFdVA5?=
 =?utf-8?B?bXpmUUY3TjBFTVltcEJJQzRpU3lWSjZ6bkxZalppTEJUMkRIb3hYSWJxK2VR?=
 =?utf-8?B?RnQrUG5qMlZ6dmJkQkJUdW1iWElhckhoRXZDV09VR2F3MVFjK1RTcktmMkhH?=
 =?utf-8?B?YTR3MjdubzZPeGdjS2lZMVBKaUJPRm9XaGRQWFNDSitqaGtrOERjb0dBazk5?=
 =?utf-8?B?TVF0a05lbFBPaWZqVFB2N3owT2xnS25rTmdlcGFRSlJWZThJNWN6a285S05q?=
 =?utf-8?B?ek1SL2ZvMGlEQnE3Q3ZvTmlyWmsrSU1YaXh6ZHVoRk1jcmE5RHFWUlFQc0Nn?=
 =?utf-8?B?a3ErVVhRUmx5YmkxeFdDN3ZiREY3dFJQMFdwODVrZjNIVHJ1ZklIcm92cVZi?=
 =?utf-8?Q?RLbB/IULgFYIJEwNkpJvbuZQfOab3x2NF1DVOyp/t/nSC?=
X-MS-Exchange-AntiSpam-MessageData-1: dB7/GSkV6NH1QQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ffef5e-9fc5-4831-fc9e-08de9643133d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:19:56.4635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1ocfze3QtPiwKu7ZmoD7641vLDXF1xu/nZwLn0jnDAXWzOOgesosMoaA+YBLBGp8zz3n3VBxHha7exIRuD4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

This has a few patches for what I had to do to get driver unload/reload
working for Hopper/Blackwell. This depends on John's Blackwell series
and Alex's unload series, although neither apply cleanly on latest
drm-rust-next for me so this might not apply as is, but hopefully can be
integrated into the other series or something as needed.

It's just two steps:
1. Make sure FSP didn't have any old message lying around that it hadn't
   consumed, which I observed sometimes happened to me on unload/reload.
2. Wait for GSP falcon to halt.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (3):
      gpu: nova-core: fsp: wait to consume message before sending another
      gpu: nova-core: add Architecture::uses_sec2() helper
      gpu: nova-core: add non-sec2 unload path

 drivers/gpu/nova-core/falcon/fsp.rs | 16 ++++++++-
 drivers/gpu/nova-core/gpu.rs        |  7 ++++
 drivers/gpu/nova-core/gsp/boot.rs   | 68 +++++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 31 deletions(-)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260409-b4-blackwell-unload-d6640795b906
prerequisite-message-id: <20260326013902.588242-1-jhubbard@nvidia.com>
prerequisite-patch-id: 684f360b8bcde8aa60a21ede276c66011837d1c4
prerequisite-patch-id: 4a3309ecef296df2a87da6a9bb1aada65c6275b2
prerequisite-patch-id: 4329316b36a3cdbdc69ee92d441a98369af5308e
prerequisite-patch-id: 1a89e18d676cedd0827c45c10ec651070e496bab
prerequisite-patch-id: 07a27de80185e4668de12ca27cb694b962fb1508
prerequisite-patch-id: 4f6d3535babd577c823bb31e3254e8501c08b80e
prerequisite-patch-id: 2d5ff77e0ecc9508d6cecf1f56a7ef3c84a85eac
prerequisite-patch-id: 04ddb7f204509ad595532a047ee7c3f83800c023
prerequisite-patch-id: d206d6d02ce4ecde692491ff740ed26ba0b4caa7
prerequisite-patch-id: 6e0b6030c3c3bfe9803388003264c9354127caa4
prerequisite-patch-id: 22b8afa61f8a51c0880b2f663b3acf5a1c3b4f3b
prerequisite-patch-id: 39e2ed088c2e1ab8164c9f187ba5252da7ead0ed
prerequisite-patch-id: 754624f3a1f545a3fa2696470535bc0d6a35c8db
prerequisite-patch-id: c2ae7b0baa9cdf5e2d749932e626c26aba9004f9
prerequisite-patch-id: 55219f9c856a182b6f11d746aa39f43c06d71c33
prerequisite-patch-id: 37958a6c896b87d3bfb93dc274c11226b264c09a
prerequisite-patch-id: 725adc556e52d09b9eaf5ff44893c88026dbef53
prerequisite-patch-id: 65ea7d6c1e59013b6043eac9892a02509486934d
prerequisite-patch-id: ff1c67ba8a2f68dbed96d98727852ba6b2705f43
prerequisite-patch-id: 9b519f929efef820598622ce961c60b08023bd77
prerequisite-patch-id: 3e4bafe4d8a3ce714cbbdaed63d507a433723318
prerequisite-patch-id: c8dc88e3ef4927033e28ed2cb8745f1fdf6cf222
prerequisite-patch-id: bf7cfd08604f8cad8d7d113d2eabe97333706988
prerequisite-patch-id: 3d69d62e324ed0a78633dd06d140c6a31fa5aac0
prerequisite-patch-id: d7db554d4123665256e7b3a1be2a770b80c07862
prerequisite-patch-id: 5e967ef35e39ef0e9f2679dea87ec70d654e5978
prerequisite-patch-id: defe154fb89b1df18d52ee8c53926974e2721e1e
prerequisite-patch-id: cdac691000a6ee280a97ee34506937665252de0e
prerequisite-patch-id: 7ae9020265203ea16122a70d1292561d577cd5c5
prerequisite-patch-id: 897bf39bb8efb97875a7d62096571bf08ad35868
prerequisite-patch-id: 07396406a0e1d94d074bc62f0a6985446f4b804f
prerequisite-message-id: <20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com>
prerequisite-patch-id: bf2577ff1e6a1151ffde8aad0bfde3e79486c8f1
prerequisite-patch-id: 48161c25415721654d27bffe124f923e1e3e2f76
prerequisite-patch-id: d50980a0003da08299b74ffd8474e46dcab3e1b6
prerequisite-patch-id: 34e78e25f97a31a14407e3c2d503bcb7b3cd2f02
prerequisite-patch-id: d9519c8417025a7045f0bfc34a6ff8db038b2c52
prerequisite-patch-id: b6f20c9337a41f9b9aac640849ee802ae748e441
prerequisite-patch-id: bdbbe4e0c2bdc5ad4600e42cc6380e163cd9eec4

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

