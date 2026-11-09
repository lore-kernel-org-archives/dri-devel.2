Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35204606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RXjABNWJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAEC10F0F1;
	Mon,  9 Nov 2026 08:56:59 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D8810E21D
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOuGRuVuDVC36KcQILBsxXjlLjfB3Z2OG2S30Rh6yq1lnDML+f69U0CF+ICTPHMotgxRuyQZ3zuuCVL4QzwLwM0EI2i8xbH7C6g5FhgdJQJTSJcWurqYVpVRyYUbRN+D4PXNPuFkgnG4yH2swEutgfhFgYWR2nF5osGjd1t5/4B1F4qGsvZHG788w/opvJVFQ9di8k489ZleqyCGU9bbNF4h5S1yfsE/nzwjufl1rbtPwF/CJRj4XW8hx0j59CpRFXbKhwDupKhdwq6BEEXSv//F0rosJPn0EWac8tnIgUcXP7n9UcVR+/YR3y5FA7TuRllaufJWc6+OMxCDFVe8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLLLpw/mLJnQmzKdkTE87qAwLpCEJ+DfecS9ijo2Tvc=;
 b=M2rAo5qo3oEN8Pe6Gm0pLV5BbBEEUdQ6idJ7RUJ5//7oUUMsKbdjK3gpOsa8LegPwpdrr1zFIdsVrVKkhmrhwpH347L+i8hg2osbJPeu7JAyZYIWVeptw3nsah9EGKl8NOxwnW7ajHInr0X3qPt5pZN2CpshuHhuIKpClmQfpkIkeTVicYn0i7YGnZV/t6SHsPqM9JzUv2BW09vTI7R6dV7SAV1AsD1PUV5+Dj+QULFSR4lkjndwWmB01z92TaxsrPjrMbjt5SJIgD8QWgChfnT+dkXe+ouba2KLV5WZg5pQeqoaYpKMlQqctxOc+wGlpuWG8RiikKNLy/6x2jZUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLLLpw/mLJnQmzKdkTE87qAwLpCEJ+DfecS9ijo2Tvc=;
 b=RXjABNWJZ/Px75rneCiasEhcBsbVi3R/RppK2SDoZ/c3icgNRb+GEaBy2ellJoZ4I12OBFBxmldfml0HY5kVtGW/LpDAQi8kZRXdbzDt4cK4ioK5ox82WDzAmcBK0gdL28eFOrfzD15wyMVXeM9c25mnzVbuH0upZRXZdJC6ebo=
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:56:45 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 08:56:44 +0000
From: "Huang, Honglei1" <Honglei1.Huang@amd.com>
To: "Hou, Lizhi" <lizhi.hou@amd.com>
CC: Matthew Brost <matthew.brost@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Santan, Sonal" <sonal.santan@amd.com>, "Hou, 
 Lizhi" <lizhi.hou@amd.com>, "ogabbay@kernel.org" <ogabbay@kernel.org>,
 "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "karol.wachowski@linux.intel.com" <karol.wachowski@linux.intel.com>, "Zhen,
 Max" <Max.Zhen@amd.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "himal.prasad.ghimiray@intel.com"
 <himal.prasad.ghimiray@intel.com>
Subject: RE: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and
 retry helpers
Thread-Topic: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and
 retry helpers
Thread-Index: AQHdbh6g02yDPfiKVUKBPZ6n4t6f47clb75Q
Date: Mon, 9 Nov 2026 08:56:44 +0000
Message-ID: <CY8PR12MB71707223ED3F56E5894FF353D9732@CY8PR12MB7170.namprd12.prod.outlook.com>
References: <20261106184217.2720718-1-lizhi.hou@amd.com>
In-Reply-To: <20261106184217.2720718-1-lizhi.hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-09T08:40:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7170:EE_|SJ2PR12MB8941:EE_
x-ms-office365-filtering-correlation-id: 85d95abc-00bc-41eb-f085-08df3e3f6130
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009221227099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102130727099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 75BOvOIF+AUonP3VkK4TK9ockYnnqN15KWncqiKkur4aQAotRp/E9L9BrlYnIu4at+DpKn+kR/FLof8kb9v35N+NCYNbecRKMfxZ5H6eeOZw4Eq7ZMCUiWuKnYXw4e5aQzmr7zLEoAQwtAfKRkYiOVefSW7xLybFvDVUww1fdsenqTvQfyb7euBFh5krUnMSKso6XjuWsuIn2SKVd4F09YYCpA0NIK83EiFYoO58F1zTnIGZJ6MQNeBcluLMnSZ9EWpu7x5V2Vram4DDFbm7Fpf4jKufuEB8Kya4OwRHNOnQ2S2vIazg9RvO6i5czO7JIT5Wx1DPnXSrtQVvysKeupe2pOOqk8AuWIgjOmwaVCodlyNlJQUElUgy/h0ILZcw/qBZ3TU8IY8rhpklnCjI4pDr0H1ekYQ0iiI7/DYjFr/XOe2uz0dKTaeLMfaIa3oZAiTHgh/0s45Don7RRCCw/4EB1LzgffjTrlCXcj5ZSVZwmhaJ//lsevhWmexD3NtdfN7jGdtUUrlyMqIDBRQnAJfnA8eiMXZQP2frIaShCuyfxRr4HyLrD4VX4/pyG+bHRz+7nzN4BzTe8JXbq4mbmmN5F1NvmxOS4ANhxI2etryJ78BL/y/B3dU06BwOKJ9Gm4gwHSHDX/SDlikP3VS5+2Mk76wAf/JsFuIMcNrQ5kWyP0xiFJbfYUJC8h2G86yG/cpKlCK7d6iRIFmBLZzYx8hKM/8NkbLY9z41o7vkMkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009221227099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102130727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hvjoGlkhwjshGbWtM9jLTFm9azptkEB1cDGDdNxwK33EKY1y4w/ftoUerw3N?=
 =?us-ascii?Q?VfyiCcRUWsyQmsznD0ZgM/uNiOqj6dVj6X9aLks84ehRs0GEcjt7ztiZwGc+?=
 =?us-ascii?Q?uiCF8YbBthHVi1Y1iJMdR5woBix12+9PXolxJ9g+v1shbN/7HrX8Iw2mU34U?=
 =?us-ascii?Q?jBGppBLgJy7W52589y8syNai+zerVCxcjRl8aPYZ7uIM8/tEJbfJ2EbS/glm?=
 =?us-ascii?Q?GHVut0f+yIeFzgrLioXIeSaC7s/pkqNHqlJaQLj2yZOZ5pIuXAKA3TJWd30p?=
 =?us-ascii?Q?PgeAT+449xeos4ccGF+56PQa+gHizu2aFgsmoK6PF5shpsRJuv1CjCXNGAmz?=
 =?us-ascii?Q?DwT/FEeH58FHKR4Kkj7n/PGYJuY3gNt1Qrp5vgyeZ3D3tn9WQ6wATlyzPVTN?=
 =?us-ascii?Q?oRQ3wcy78HUqFwapwkkaGiRQFYlIJuoxhJDi5Q8OxxJBGTn4drIM+tP/pNtp?=
 =?us-ascii?Q?fYBrqlhzj8uaKnjYGdJeILr8Lj6lfvt5iBKDGyqzxbZcZ+hjHH6OaePxAMG4?=
 =?us-ascii?Q?2EUzL6WIWgiCj3nnPPjRJfB8XuhkGfagUoFVYnp/5jhRCdZEfMUzNxm5TBdD?=
 =?us-ascii?Q?l1kqngTNnYj5FqDpWZ4mZ04QC0UPsKjml+DNaczxftwqmNwE7rLJ9yVLTIyg?=
 =?us-ascii?Q?tpOlGlcNvkqOcPDPqTNIy0qpUjB0KtDvLjPmUwHo+pVzlrfViTBL38Hr3Ib8?=
 =?us-ascii?Q?26KVCTnPraw3PFgxd8XG6BoiD6wk323Qg+42NidZAhx7hU7JU57qS41hCoNN?=
 =?us-ascii?Q?N8fe/4ElPLJwsV/ridC0bvYSeO8u2QJ9jM74Migq5EMVYr8E/4Q5JyP+jKiy?=
 =?us-ascii?Q?Dy5m6YegzyhMOZp5L0jWyna+b5IrT+GoSHSqhdgWEGix6I9jLhybuTc89J1k?=
 =?us-ascii?Q?ys/kg96+wypOTHKBvBCf6BwboCFVtLDWk+cNGOOvgZdbS9sW9CkxHWNv85l0?=
 =?us-ascii?Q?c5NHg37cAF1u6FvmWDyhX8d48f+2bTewKNcMKTR/KShqIZOB5+NeUuQhAUBT?=
 =?us-ascii?Q?MDgM7YJRVJ1XALUgni28PnwQhhyyI0ys8qP3jJY/gJ8AEVlXg9X6D59U+xr1?=
 =?us-ascii?Q?gynWZ2pDA6YHdF9m09ibRRw/cTk60nwmz75ldt0qxMIgQAGarYnRz+gXlKc7?=
 =?us-ascii?Q?HYva/TdmB9q5DyW0ykJydwTI4BSx1+SXGQUT5SsR3oEf64qOl1QsVTrGusYW?=
 =?us-ascii?Q?zUWJYAJgG/M1QOjqyKimmPeGFcK71iMNLIHWhJjjyTm84nS1fjmJQrNMSEE7?=
 =?us-ascii?Q?66MLQ4SWIbAHNu/kvLXvF/SLRIsj5+sa7ttkxwnJHXbt/fRdt5zPvfQ/rxIl?=
 =?us-ascii?Q?ulriUQatqEkosLvjvQauepEy0b3ciyt7PuFyOLglRsIKoFxN8RuLPHaM2OFu?=
 =?us-ascii?Q?moBhV6pgtztX/8Ac6BLPrxeDVcHfpqZANKtVpewUgQnD6+taSqnqhhEc8HsW?=
 =?us-ascii?Q?H1BrhkYVzutcPl69r04FxrVIm028HWd4JuHG3/pB1phBq5j3bHSDBjeMG/uH?=
 =?us-ascii?Q?NwefsSUYHlffj2NHn8m+/2jV0dOtZcyRy/xy4OcLfrmknRIGZZq58HreD20e?=
 =?us-ascii?Q?UsO8vARdQ8QamiIKu6qvvb43idXV2+rj7e34LVMBwI6lXYeBb2HmGZ8/XYQ1?=
 =?us-ascii?Q?RHpzPVCTbkX/wfyZwNNhKF3NFZ59MOnHwpMABPILFOinhOR/a+fCKAYVJ2L0?=
 =?us-ascii?Q?ZDjb+XQqEQpE66VLawUdgUETGdBQMv3LD0g2xeCJpwQtllWh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d95abc-00bc-41eb-f085-08df3e3f6130
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 08:56:44.4219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1qfOLRwv4MuSJAEokATtNn8V1rS7i0+nOHdsWWXKtsaSxPhQKv+41jd8HVmpnT4tgHJyFunBP5m5wwh6vYFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Honglei Huang <honghuan@amd.com>

-----Original Message-----
From: Lizhi Hou <lizhi.hou@amd.com>
Sent: Saturday, November 7, 2026 2:42 AM
To: ogabbay@kernel.org; quic_jhugo@quicinc.com; dri-devel@lists.freedesktop=
.org; Limonciello, Mario <Mario.Limonciello@amd.com>; karol.wachowski@linux=
.intel.com; Zhen, Max <Max.Zhen@amd.com>; thomas.hellstrom@linux.intel.com;=
 himal.prasad.ghimiray@intel.com; Huang, Honglei1 <Honglei1.Huang@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>; linux-kernel@vger.kernel.org; =
Santan, Sonal <sonal.santan@amd.com>; Hou, Lizhi <lizhi.hou@amd.com>
Subject: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and retry=
 helpers

From: Matthew Brost <matthew.brost@intel.com>

Drivers which only use the drm_gpusvm_pages API (no drm_gpusvm_range) have =
no way to mark pages unmapped from their MMU notifier, as
drm_gpusvm_range_set_unmapped() requires a range. They also have to open co=
de the mmu_interval_read_retry() check on the recorded notifier_seq to comm=
it pages faulted with &drm_gpusvm_ctx.no_dma_map.

Split the pages part of drm_gpusvm_range_set_unmapped() into drm_gpusvm_pag=
es_set_unmapped(), and add drm_gpusvm_pages_read_retry() which performs the=
 commit side check with a lockdep assert on the notifier lock.

Assisted-by: LLM
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 49 +++++++++++++++++++++++++-----------
 include/drm/drm_gpusvm.h     | 29 +++++++++++++++++++++
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c in=
dex 03dbe304e4b8f..63a26919f59db 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1761,9 +1761,8 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm=
 *gpusvm,
  *
  * With &drm_gpusvm_ctx.no_dma_map no mapping state is recorded, so
  * drm_gpusvm_pages_valid() never returns true and success is only a snaps=
hot:
- * the caller must recheck mmu_interval_read_retry() against the recorded
- * &drm_gpusvm_pages.notifier_seq under the notifier lock, and hold it unt=
il
- * its work is visible to invalidation.
+ * the caller must recheck drm_gpusvm_pages_read_retry() under the
+ notifier
+ * lock, and hold it until its work is visible to invalidation.
  *
  * Return: 0 on success, negative error code on failure.
  */
@@ -2021,6 +2020,38 @@ bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusv=
m, unsigned long start,  }  EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);

+/**
+ * drm_gpusvm_pages_set_unmapped() - Mark GPU SVM pages as unmapped
+ * @gpusvm: Pointer to the GPU SVM structure.
+ * @pages: Pointer to the GPU SVM pages structure(s).
+ * @pages_count: Number of GPU SVM pages structure(s) passed in.
+ *
+ * Mark @pages as unmapped, after which drm_gpusvm_get_pages() fails
+with
+ * -EFAULT for them. Intended to be called from the driver's MMU
+notifier on
+ * MMU_NOTIFY_UNMAP, and usable without a &drm_gpusvm_range by drivers
+that
+ * only use the drm_gpusvm_pages API. The caller must hold the notifier
+lock
+ * in write mode.
+ */
+void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
+                                  struct drm_gpusvm_pages *pages,
+                                  unsigned int pages_count)
+{
+       unsigned int i;
+
+       lockdep_assert_held_write(&gpusvm->notifier_lock);
+
+       for (i =3D 0; i < pages_count; ++i) {
+               struct drm_gpusvm_pages_flags flags =3D {
+                       .__flags =3D pages[i].flags.__flags,
+               };
+
+               flags.unmapped =3D true;
+               /* WRITE_ONCE pairs with READ_ONCE for opportunistic checks=
 */
+               WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
+       }
+}
+EXPORT_SYMBOL_GPL(drm_gpusvm_pages_set_unmapped);
+
 /**
  * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
  * @range: Pointer to the GPU SVM range structure.
@@ -2039,20 +2070,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusv=
m_range *range,
        struct drm_gpusvm_range_flags range_flags =3D {
                .__flags =3D range->flags.__flags,
        };
-       unsigned int i;

-       lockdep_assert_held_write(&range->gpusvm->notifier_lock);
+       drm_gpusvm_pages_set_unmapped(range->gpusvm, pages, pages_count);

        range_flags.unmapped =3D true;
-       for (i =3D 0; i < pages_count; ++i) {
-               struct drm_gpusvm_pages_flags flags =3D {
-                       .__flags =3D pages[i].flags.__flags,
-               };
-
-               flags.unmapped =3D true;
-               /* WRITE_ONCE pairs with READ_ONCE for opportunistic checks=
 */
-               WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
-       }
        if (drm_gpusvm_range_start(range) < mmu_range->start ||
            drm_gpusvm_range_end(range) > mmu_range->end)
                range_flags.partial_unmap =3D true;
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h index 4d31=
c6bba7455..b43432af56377 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -349,6 +349,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_r=
ange *range,
                                   unsigned int pages_count,
                                   const struct mmu_notifier_range *mmu_ran=
ge);

+void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
+                                  struct drm_gpusvm_pages *pages,
+                                  unsigned int pages_count);
+
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
                         struct drm_gpusvm_pages *svm_pages,
                         unsigned int num_pages,
@@ -383,6 +387,31 @@ static inline void drm_gpusvm_init_pages(struct drm_gp=
usvm_pages *svm_pages,
        svm_pages->notifier_seq =3D LONG_MAX;
 }

+/**
+ * drm_gpusvm_pages_read_retry() - Check whether GPU SVM pages went
+stale
+ * @gpusvm: Pointer to the GPU SVM structure.
+ * @svm_pages: Pointer to the drm_gpusvm_pages.
+ * @notifier: The notifier passed to drm_gpusvm_get_pages() for @svm_pages=
.
+ *
+ * Check whether @notifier was invalidated since the last successful
+ * drm_gpusvm_get_pages() for @svm_pages. This is the commit side check
+for
+ * pages faulted with &drm_gpusvm_ctx.no_dma_map, where no mapping
+state is
+ * tracked. Pages that were never faulted always report as stale. The
+caller
+ * must hold the notifier lock and keep holding it until its use of the
+pages
+ * is visible to the invalidation path.
+ *
+ * Return: True if the pages must be faulted again, false otherwise.
+ */
+static inline bool
+drm_gpusvm_pages_read_retry(struct drm_gpusvm *gpusvm,
+                           struct drm_gpusvm_pages *svm_pages,
+                           struct mmu_interval_notifier *notifier) {
+       lockdep_assert_held(&gpusvm->notifier_lock);
+
+       return mmu_interval_read_retry(notifier, svm_pages->notifier_seq); =
}
+
 /**
  * drm_gpusvm_pages_first_dma() - Resolve the device address array
  * @svm_pages: Pointer to the drm_gpusvm_pages.

base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
--
2.34.1

