Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E563AFB3CE2
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2ED10E513;
	Mon, 30 Mar 2026 09:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="WK3HS0Qk";
	dkim-atps=neutral
Received: from CP4P284CU005.outbound.protection.outlook.com
 (mail-brazilsouthazolkn19011034.outbound.protection.outlook.com
 [52.103.21.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E9510E0A0;
 Sun, 29 Mar 2026 22:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K70+wBoB7rUiPiPVmERjEcnTI54j4Z/8LlbLeyoVUL6jzz3CRNwEXS9nboJvBsuR9o5pnZh/PRiDAh2aRCYJvm45b97fTD8MBodC57u97ko1+WL9KkfC9E75hBEd/24RP0Jsl2luMfxZ+xGRg6blDAX4w0mzSjXBFyWBO10DHUsPhItsOOIh+7yhtXrnhF2MhYoxohHyskC85Sk9f6sudmNPBzGilKmBVwOwie+AyIu3Cg2DMByXoqT1dKZexVnrVvpYZwgH+GwtFaV+wJj2jOu5Bc3vDbR6M4xcLNJxvwuQeby7fOmQViXErpTTCboF8b6fSL8ncakl3t71P9XCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlEd8/dB4frJ0xj+Zj1SnIfstxKLhi3F3D2uCJIm0os=;
 b=TxEJ5Yx+syTTWG4UnbGr/6CwQd9Lmcxs959fthRvNaeTo8Iems4ASo3QKAh8fB0op3KcV41j+5YR0APF23WvLvTJDVrpj15NnYLbc+iReTzE0eBNWV+BKLlna5fKg4tsMKEdBwUnDZcE7etMoY2BuNEbyf8/nO8bJ20vDWe2FKEre1NHLXwJayw8JGBzubg4vyj3RxNGkDJp+Ya7duNgE8iVvUAzLYO5nyhTSem8RYa40c7UlNST5BhLGFeox0IMYDu2cAaxFxc5yA9PdnrCfSwi2st3qFOnsql2ey0R1AjJl/eHFrhCD/fxDIcdtSaGBdX1nAKthlEjP+4jBVpy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlEd8/dB4frJ0xj+Zj1SnIfstxKLhi3F3D2uCJIm0os=;
 b=WK3HS0Qkz6bp3imhEHb2C6QdtnNrhAoNOARlYPXM8/OkicYOl2p7apy+64LSQ2B9PHQEEgj8XNiAfWdWj7yDosZ1niO1m54yqJDCodiKriyv//xVWkregoMxE0TePL/J+b9ejy5voABnCW/fQZrbwV8ZSWjOO2uqtOr9JkG8hKpayBYkas5gtHiHJ/ICDIw7grFOxMNdd0tBt3A+UgGuDWOY6YXbpr+0bceJz02LI8T3jfVlz2Rs9JtvhECyfDAhka0lsehoGJCSUTJnwBrjS6MVXmx7dcPl5FqHqQReryuAGoOCCRRM1pLU7YKBFu6jhDssU8f1CNUqRm9qoxNJqw==
Received: from CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:38c::8)
 by RIXP284MB3865.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:17c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Sun, 29 Mar
 2026 22:22:53 +0000
Received: from CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM
 ([fe80::2ed0:cdde:9d51:f021]) by CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM
 ([fe80::2ed0:cdde:9d51:f021%5]) with mapi id 15.20.9745.027; Sun, 29 Mar 2026
 22:22:53 +0000
From: Yuri Martins <yurimartins2004@hotmail.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Auld <matthew.auld@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe/bo: Cache vram_region_gpu_offset in struct xe_bo
Date: Sun, 29 Mar 2026 19:22:47 -0300
Message-ID: <CP9P284MB3908AC9B3875FD63E955D139A055A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CP5P284CA0156.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:22a::15) To CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:38c::8)
X-Microsoft-Original-Message-ID: <20260329222251.600976-1-yurimartins2004@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CP9P284MB3908:EE_|RIXP284MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 297967e9-84f3-4063-a14d-08de8de1b83e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8060799015|41001999006|23021999003|19110799012|39105399006|5072599009|15080799012|5062599005|6090799003|40105399003|440099028|3412199025|18061999006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUVpM3lybXcyeEt1R0ZmWEtWUFBHbXVDSHRmM0pGZy9qeStCdzdXbWxGTVZ6?=
 =?utf-8?B?VzlOMlBHUzNPNm5laG1MeHA4NktCcjBqcjN6YTVXdEFDcysvK1piUXFvUU94?=
 =?utf-8?B?cjJqWGxYdUM5SEoyd0thNUlLTW5FWlFLeWRqWFNEY3RBRU9rcWVjWUNqNkZ1?=
 =?utf-8?B?cGZnd0VCVG8xY3hqUFkxNXozRXNmNGtPRUlmODlCVEdRUXdmT25TbjV4Szhj?=
 =?utf-8?B?TmlJVnZlMmRzU002aFFhN3JOVGtha2xuU1BLSmI1TjRGRnNWZmYyM0ViQkFT?=
 =?utf-8?B?dXFkU3Q2NTlqVU5VTGRsbWtCWnNvRUZFUExHdTczYTUxci9vN0V2Z1djODZY?=
 =?utf-8?B?OXB3bTVUbUpQdlM3UkdrUkcyOVo2TENXdWZnZDRmTWIraUxWMVVlS0hnZTJK?=
 =?utf-8?B?ZTNCY1BFRERVRmhlaGhhZlcycVVyRGpwWHBhMkU5VTJGcjJza05BQ0lqSSt4?=
 =?utf-8?B?ZUtSeXY1ZEJQdkI0OTlWTGt3aCtObkR1Mmg0VnZnakJweG9jL1BMcEZBYkpl?=
 =?utf-8?B?VWpDWWRvNGxyaXJOYUlqdm8zWDlnRnZxK1FpOHRhcklCVW9Hc3ljZ0NjMy8w?=
 =?utf-8?B?RlM2anYra05RZFpzcXREMVZRVHQ3b0ZvdlVWck85aitqbzBxWDJXN3lINWhk?=
 =?utf-8?B?cksvTGE0UFJTRmdEUlFJdUt1TmExSjJrbDk4bHVRWHJRZ3lRRUc0NHFoSXJa?=
 =?utf-8?B?dG9qRVdpU2d3dmQ1bEovNmRuWGVRTzBZeUIzMklpVnZ5dW5WTFVmdlJSVVZt?=
 =?utf-8?B?aXQybXNmcEgwTGxIOWxNUjJpSVlZNC8ybWV0d2hxcUFkazVDb25XMWRDVFFX?=
 =?utf-8?B?Y3M1cmxFT0ZuS3cxKzNLTncxdE9qZTh6aWdZRVRLRG1ZMHU5Q3gxSHJ2SlhP?=
 =?utf-8?B?dHlHWGtXTFp1MEE4cWx2L21GTUJvMGQxVnVJbXEvZU02NlZRRnZMNWFUN1Jy?=
 =?utf-8?B?T3JHUkJKS1czam5DTEhiZWEwSXdSbEc5QU40QmFvbC9oMVZVeVN6VWExeENz?=
 =?utf-8?B?L2RBc2d4UlJUa3dBdEd3aEZLWFV5alhwNjlWcnhQeU5XcXB4eUtBNjRNeWtt?=
 =?utf-8?B?YXQvck5TZWY1enVrYStXRU1HVGZ0RXM0T2xZck54VXhvRGhlWmxhdGhMVjRt?=
 =?utf-8?B?TXc4eDRXaldKMTRySWFZM0RTQzJrelNpaVc1R1pKVDlMaDZXa2FzUldXc01D?=
 =?utf-8?B?MEJ3a1AxSUtHRXRNbFM3N055bExzc0QvVWs2VzQxLzFFdW1yaUFpNjI3VGJ6?=
 =?utf-8?B?dW9nNW5Vam0vNGhOV2lUTko1Mms1dkl5UExEU3A5dGh2ekZ3T2FORlVCbmQr?=
 =?utf-8?B?U2IvelBJS3I0dk9MK0tRc0hocHpJRFg5aUdDZnprekVSNFpCeWs2L2NRYnVy?=
 =?utf-8?B?enZSQkRFUXNyM1E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU41TDlJeU9zZEJvNEozNTNub2pmaTRnQmhBNVRldDU5UFVYV25QWXI4eFVE?=
 =?utf-8?B?aS8yR3U4ZzA4UkM3bDlyMGhpSWcrNmFPUHFSR2QyR1c0WFBUVThxbVFIWlpm?=
 =?utf-8?B?a0pTNXBaM3FmNHNKckZSQmNYL05qcXZTNkFuSi9qYmpGd2ZHZUVXWTJ3TUdx?=
 =?utf-8?B?YkdYdEdJTHR2SWhuTFpXWDJRUHM5YkUveVIrUjNlWUpUcGN0MWNxV0xVc2xH?=
 =?utf-8?B?V3p6aUlSZXhmbjNMVllpRGh1VjhRQjBVV3d3RXQzN3BoU3hiRjVzMHppVXFH?=
 =?utf-8?B?SHkyL0RiN1ZRejREcmFRUHBEb2ZEMm5GRzdHWm9Yczh4ZjBhME5EUHA3UTM5?=
 =?utf-8?B?YVJzU1RLTnRKVTk3aFhKQUpMOWFCcXY5ZVpXRXBJUFdTWjdhY0hNdzRkNmgw?=
 =?utf-8?B?MjVBNDB2K2lPL055Y2hNV3lLQ3N3Vm9SUVFyeDYvYmRkWjdDWVJTRFNiNHlR?=
 =?utf-8?B?a21RdmJXMEVrT0ZIWkN2SklyWHYvN0RZOFVlMHJkRmZkNnlkQU16alY1dTBC?=
 =?utf-8?B?TnpTZVlqdGNVV3NXNHJmSVRaaVd3N0gySzREOUlqb3VzTDBXSGl6emRJK3Yz?=
 =?utf-8?B?MHVJSXBRbmRKTzJuSXZvQzRxWjhNeFFpNG5LMXhlT242UC9UYjNPQVpFVVdQ?=
 =?utf-8?B?clY1RjA5VGd2STJYaVZtSWJnRHFVWTl3anBXQzBvVzIya1dqRWxycVBOM0Vw?=
 =?utf-8?B?bCtuYjZyRmNDTGFKN0dmT2w0Zy9keTkwSTI0WTdpQzUwUVpxTk50cVV6VktB?=
 =?utf-8?B?aGMrZXJNQW8wV0k4WkwrUjBjZkZMcHY3Qi8wcCtUeDE3MkFnL2xMRkMyWUxQ?=
 =?utf-8?B?enpDbGVmL1lUUzhyR2hTMW4vRVFFdmViNXkwMnRGQ2hkaWxUaDVUbHhBZzF4?=
 =?utf-8?B?UWpFNkxiM2I4YlJLaGt5ZHVNd3N2YkpGOXNaZDBDYmZucVVLajJaY0ppUTFn?=
 =?utf-8?B?WFpOdGFHdm9FdjhqOHVwaFRtdytmam1QT0p2dkF6MmwrVTl3S05HbXVYWWgw?=
 =?utf-8?B?NVM1TzBmWFAyVTljM3h1WloxeGtGSUVzR1U2MTA3aXl6WmdYNk1OazBrTTBy?=
 =?utf-8?B?azhBZk9WdWdwbVVKZGFSK0dBNUhSTWZuR2svcDN6Z3NZdEdVbXdzb1VuMWpX?=
 =?utf-8?B?NUNPdCt5VHBRM2FrN3J1SFVGUzJxb1NhQ2F4cDZhRGl6T2plMGgxUXB6VTNZ?=
 =?utf-8?B?YXREdjQ5UjYrdGZwbXNqQkdJYlZsdDVDNVlEZmo2UGVlRFIrcHNJVkJxU3RR?=
 =?utf-8?B?OGx4Z0poRkswQXNzN21FNy8zekI3UU9vSG1jeUIyVXVSaTY1K0E3VTBRUVpU?=
 =?utf-8?B?RXVmalVRVlpUU3NBSTNFRGhjRlV4aFBjaDl5VEdvQWJhQ2luNTFZUDdzZjZM?=
 =?utf-8?B?dTd4UTdPVXJwb2ZlZjdPbjVaTHBtQUd0SSt6cE55cGhIVDRyaWRHNFJaQ1Jv?=
 =?utf-8?B?LzVja0FSczdSdlBFdTliQkZZUXFMTWpJSXNuQzVUZkJMdWxoWXhhazFSQ2xj?=
 =?utf-8?B?UThxTVFhdDhtaSt6Zmd3WlZWKzZxWUYxNFg1VmJEUkRIbE1ERTVpeldaQ09L?=
 =?utf-8?B?U3BQcWkzZ0ZGOEIyK1BEd3JMZmNjRUIzbW5PdHZpZjlmUUpRK0J4Unh6Ynpj?=
 =?utf-8?B?dkVacm0rVWhKd0JWeWVyOGRsN0FHa1BpRzlBcFZqUzRZeXQyQXd2VVVTRXV5?=
 =?utf-8?B?aEJ0am5JNjczVTRoelJuWFJsVGZZVWYzTUVYbFBXTW5idHRlMEU4VTFJbVlF?=
 =?utf-8?B?YkNRdlkyUWIxdEhRcFQzSGVUOXJIQzF3QVZBZDZTZFN5eUpQWEJHWVB5YmxB?=
 =?utf-8?B?ZG1ZWFlhRUJZdDNqWGlyNUxoNTllZjdGVHg5aSthQmV3MzdZS0ZNYzJyUFA0?=
 =?utf-8?B?aWhwMlpEUU5DbWJKNE1YRC9GeGxsZ0hCdXllVzd4am9mUnJ2VmpXSWVuTGhm?=
 =?utf-8?B?Qyt1NHJTL1ZGSENvYnNCOFhSdVdqUDZITVV6akZiWFR0cWxGMHBYLzdzb1Rq?=
 =?utf-8?B?VVM4UFZEbnhRPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-da224.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 297967e9-84f3-4063-a14d-08de8de1b83e
X-MS-Exchange-CrossTenant-AuthSource: CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 22:22:53.6661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RIXP284MB3865
X-Mailman-Approved-At: Mon, 30 Mar 2026 09:06:21 +0000
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

The vram_region_gpu_offset() helper chases pointers through TTM resource
manager structures on every call. An XXX comment in the codebase noted
this was a problem in the VM bind hot path and suggested caching the
value with a recalculation on BO move.

Add a vram_gpu_offset field to struct xe_bo that is updated in
xe_bo_move() at the 'out' label, which is the convergence point for all
move paths. Provide xe_bo_vram_gpu_offset() as a static inline accessor.

Convert five callers that always operate on the BO's current resource:
  - xe_pt.c: xe_pt_stage_bind() (VM bind hot path)
  - xe_bo.c: __xe_bo_addr()
  - xe_ggtt.c: xe_ggtt_map_bo()
  - xe_lmtt.c: lmtt_insert_bo()
  - xe_migrate.c: xe_migrate_access_memory()

Two callers in xe_migrate.c (pte_update_size and emit_pte) are
intentionally not converted because they receive a ttm_resource that
may refer to a move destination rather than the BO's current placement.

Replace the XXX comment on vram_region_gpu_offset() with proper kernel
doc that directs callers to prefer the cached accessor.

Add a KUnit live test (xe_bo_vram_gpu_offset_kunit) that validates cache
consistency across BO creation in VRAM, eviction to system memory, and
restoration back to VRAM.

Tested on ASUS Zenbook S14 (Intel Core Ultra 7 258V) with xe_live_test
module on Fedora.

Signed-off-by: Yuri Martins <yurimartins2004@hotmail.com>
---
 drivers/gpu/drm/xe/tests/xe_bo.c | 117 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo.c       |  17 +++--
 drivers/gpu/drm/xe/xe_bo.h       |  15 ++++
 drivers/gpu/drm/xe/xe_bo_types.h |   6 ++
 drivers/gpu/drm/xe/xe_ggtt.c     |   2 +-
 drivers/gpu/drm/xe/xe_lmtt.c     |   2 +-
 drivers/gpu/drm/xe/xe_migrate.c  |   2 +-
 drivers/gpu/drm/xe/xe_pt.c       |   2 +-
 8 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 49c95ed67d7e..ed65e25c1b11 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -603,9 +603,126 @@ static void xe_bo_shrink_kunit(struct kunit *test)
 	shrink_test_run_device(xe);
 }
 
+/*
+ * Test that bo->vram_gpu_offset is kept in sync with the value computed
+ * by vram_region_gpu_offset() across BO creation, eviction to system
+ * memory, and restoration back to VRAM.
+ */
+static void vram_gpu_offset_test_run_tile(struct xe_device *xe,
+					  struct xe_tile *tile,
+					  struct kunit *test)
+{
+	struct xe_bo *bo;
+	unsigned int bo_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile);
+	struct drm_exec *exec = XE_VALIDATION_OPT_OUT;
+	u64 expected;
+	long timeout;
+	int ret;
+
+	kunit_info(test, "Testing vram_gpu_offset cache on tile %u\n", tile->id);
+
+	bo = xe_bo_create_user(xe, NULL, SZ_1M, DRM_XE_GEM_CPU_CACHING_WC,
+			       bo_flags, exec);
+	if (IS_ERR(bo)) {
+		KUNIT_FAIL(test, "Failed to create bo: %pe\n", bo);
+		return;
+	}
+
+	xe_bo_lock(bo, false);
+
+	/* After creation the BO should be in VRAM on DGFX. */
+	ret = xe_bo_validate(bo, NULL, false, exec);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to validate bo: %d\n", ret);
+		goto out_unlock;
+	}
+
+	/* Wait for any async clears. */
+	timeout = dma_resv_wait_timeout(bo->ttm.base.resv,
+					DMA_RESV_USAGE_KERNEL, false, 5 * HZ);
+	if (timeout <= 0) {
+		KUNIT_FAIL(test, "Timeout waiting for bo after validate.\n");
+		goto out_unlock;
+	}
+
+	expected = vram_region_gpu_offset(bo->ttm.resource);
+	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), expected);
+
+	if (xe_bo_is_vram(bo))
+		KUNIT_EXPECT_NE(test, xe_bo_vram_gpu_offset(bo), 0);
+
+	/* Evict to system memory — cache must become 0. */
+	ret = xe_bo_evict(bo, exec);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to evict bo: %d\n", ret);
+		goto out_unlock;
+	}
+
+	timeout = dma_resv_wait_timeout(bo->ttm.base.resv,
+					DMA_RESV_USAGE_KERNEL, false, 5 * HZ);
+	if (timeout <= 0) {
+		KUNIT_FAIL(test, "Timeout waiting for bo after evict.\n");
+		goto out_unlock;
+	}
+
+	expected = vram_region_gpu_offset(bo->ttm.resource);
+	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), expected);
+	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), (u64)0);
+
+	/* Restore back to VRAM — cache must be updated again. */
+	ret = xe_bo_validate(bo, NULL, false, exec);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to validate bo back to vram: %d\n", ret);
+		goto out_unlock;
+	}
+
+	timeout = dma_resv_wait_timeout(bo->ttm.base.resv,
+					DMA_RESV_USAGE_KERNEL, false, 5 * HZ);
+	if (timeout <= 0) {
+		KUNIT_FAIL(test, "Timeout waiting for bo after restore.\n");
+		goto out_unlock;
+	}
+
+	expected = vram_region_gpu_offset(bo->ttm.resource);
+	KUNIT_EXPECT_EQ(test, xe_bo_vram_gpu_offset(bo), expected);
+
+	if (xe_bo_is_vram(bo))
+		KUNIT_EXPECT_NE(test, xe_bo_vram_gpu_offset(bo), 0);
+
+out_unlock:
+	xe_bo_unlock(bo);
+	xe_bo_put(bo);
+}
+
+static int vram_gpu_offset_test_run_device(struct xe_device *xe)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct xe_tile *tile;
+	int id;
+
+	if (!IS_DGFX(xe)) {
+		kunit_skip(test, "non-discrete device\n");
+		return 0;
+	}
+
+	guard(xe_pm_runtime)(xe);
+	for_each_tile(tile, xe, id)
+		vram_gpu_offset_test_run_tile(xe, tile, test);
+
+	return 0;
+}
+
+static void xe_bo_vram_gpu_offset_kunit(struct kunit *test)
+{
+	struct xe_device *xe = test->priv;
+
+	vram_gpu_offset_test_run_device(xe);
+}
+
 static struct kunit_case xe_bo_tests[] = {
 	KUNIT_CASE_PARAM(xe_ccs_migrate_kunit, xe_pci_live_device_gen_param),
 	KUNIT_CASE_PARAM(xe_bo_evict_kunit, xe_pci_live_device_gen_param),
+	KUNIT_CASE_PARAM(xe_bo_vram_gpu_offset_kunit, xe_pci_live_device_gen_param),
 	{}
 };
 
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index a7c2dc7f224c..30c4fe326827 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1164,6 +1164,9 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		ret = xe_sriov_vf_ccs_attach_bo(bo);
 
 out:
+	bo->vram_gpu_offset = ttm_bo->resource ?
+		vram_region_gpu_offset(ttm_bo->resource) : 0;
+
 	if ((!ttm_bo->resource || ttm_bo->resource->mem_type == XE_PL_SYSTEM) &&
 	    ttm_bo->ttm) {
 		long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
@@ -2908,9 +2911,15 @@ int xe_managed_bo_reinit_in_vram(struct xe_device *xe, struct xe_tile *tile, str
 	return 0;
 }
 
-/*
- * XXX: This is in the VM bind data path, likely should calculate this once and
- * store, with a recalculation if the BO is moved.
+/**
+ * vram_region_gpu_offset - Compute GPU offset for a TTM resource's memory region
+ * @res: The TTM resource.
+ *
+ * Computes the GPU-visible offset for @res based on its current memory type.
+ * Callers that always operate on a BO's current resource should prefer
+ * xe_bo_vram_gpu_offset() which returns a cached value.
+ *
+ * Return: The GPU-visible offset, or 0 for system/TT memory.
  */
 uint64_t vram_region_gpu_offset(struct ttm_resource *res)
 {
@@ -3173,7 +3182,7 @@ dma_addr_t __xe_bo_addr(struct xe_bo *bo, u64 offset, size_t page_size)
 
 		xe_res_first(bo->ttm.resource, page << PAGE_SHIFT,
 			     page_size, &cur);
-		return cur.start + offset + vram_region_gpu_offset(bo->ttm.resource);
+		return cur.start + offset + xe_bo_vram_gpu_offset(bo);
 	}
 }
 
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 68dea7d25a6b..d911f7327e8b 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -342,6 +342,21 @@ bool xe_bo_is_vm_bound(struct xe_bo *bo);
 bool xe_bo_has_single_placement(struct xe_bo *bo);
 uint64_t vram_region_gpu_offset(struct ttm_resource *res);
 
+/**
+ * xe_bo_vram_gpu_offset - Return cached GPU offset for BO's memory region
+ * @bo: The buffer object.
+ *
+ * Returns the GPU offset for the BO's current memory region. This value
+ * is cached on the BO and updated whenever the BO is moved, avoiding
+ * repeated pointer chasing through TTM resource manager structures.
+ *
+ * Return: The GPU-visible offset, or 0 for system/TT memory.
+ */
+static inline u64 xe_bo_vram_gpu_offset(struct xe_bo *bo)
+{
+	return bo->vram_gpu_offset;
+}
+
 bool xe_bo_can_migrate(struct xe_bo *bo, u32 mem_type);
 
 int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct ttm_operation_ctx *ctc,
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index ff8317bfc1ae..622a1ec8231e 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -109,6 +109,12 @@ struct xe_bo {
 	 */
 	u64 min_align;
 
+	/**
+	 * @vram_gpu_offset: Cached GPU offset for BO's current memory
+	 * region, updated on move. Protected by the BO's dma-resv lock.
+	 */
+	u64 vram_gpu_offset;
+
 	/**
 	 * @madv_purgeable: user space advise on BO purgeability, protected
 	 * by BO's dma-resv lock.
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index a848d1a41b9b..a24ae3e0e553 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -705,7 +705,7 @@ static void xe_ggtt_map_bo(struct xe_ggtt *ggtt, struct xe_ggtt_node *node,
 						   pte | xe_res_dma(&cur));
 	} else {
 		/* Prepend GPU offset */
-		pte |= vram_region_gpu_offset(bo->ttm.resource);
+		pte |= xe_bo_vram_gpu_offset(bo);
 
 		for (xe_res_first(bo->ttm.resource, 0, xe_bo_size(bo), &cur);
 		     cur.remaining; xe_res_next(&cur, XE_PAGE_SIZE))
diff --git a/drivers/gpu/drm/xe/xe_lmtt.c b/drivers/gpu/drm/xe/xe_lmtt.c
index 0c726eda9390..f9257ba1728b 100644
--- a/drivers/gpu/drm/xe/xe_lmtt.c
+++ b/drivers/gpu/drm/xe/xe_lmtt.c
@@ -492,7 +492,7 @@ static void lmtt_insert_bo(struct xe_lmtt *lmtt, unsigned int vfid, struct xe_bo
 	lmtt_assert(lmtt, IS_ALIGNED(xe_bo_size(bo), page_size));
 	lmtt_assert(lmtt, xe_bo_is_vram(bo));
 
-	vram_offset = vram_region_gpu_offset(bo->ttm.resource);
+	vram_offset = xe_bo_vram_gpu_offset(bo);
 	xe_res_first(bo->ttm.resource, 0, xe_bo_size(bo), &cur);
 	while (cur.remaining) {
 		addr = xe_res_dma(&cur);
diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index fc918b4fba54..bdaea4979e89 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -2499,7 +2499,7 @@ int xe_migrate_access_memory(struct xe_migrate *m, struct xe_bo *bo,
 
 	do {
 		struct dma_fence *__fence;
-		u64 vram_addr = vram_region_gpu_offset(bo->ttm.resource) +
+		u64 vram_addr = xe_bo_vram_gpu_offset(bo) +
 			cursor.start;
 		int current_bytes;
 		u32 pitch;
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 8e5f4f0dea3f..7cfce1a92a1a 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -782,7 +782,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 	}
 
 	xe_walk.default_vram_pte |= XE_PPGTT_PTE_DM;
-	xe_walk.dma_offset = (bo && !is_purged) ? vram_region_gpu_offset(bo->ttm.resource) : 0;
+	xe_walk.dma_offset = (bo && !is_purged) ? xe_bo_vram_gpu_offset(bo) : 0;
 	if (!range)
 		xe_bo_assert_held(bo);
 
-- 
2.43.0

