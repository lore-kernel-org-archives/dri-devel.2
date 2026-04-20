Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F97F36C5F
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B424710E556;
	Mon, 20 Apr 2026 12:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kOuayo1m";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABC610E551;
 Mon, 20 Apr 2026 12:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeFf0uioAdzd0o8nu8cRj55wIwO/gCv1T6/xxAXBKKvy0FBnYbUGpeaPsDlufzGaBQMSZz+iIVdTlECOiyAZQp2aKwaY+YV/Q7hrbdUzov3qqZ1O+P3RlCEQV1SCCd4whdz2kFyPF8XA1PA03cgSsBy0inOadrInOtxLsRfbYTsg+GA1ScABvO/n1bVS8y0Pm2IzcyZyyTrObkNRfBlbG7bAue1xeWb50SCwZiV8NaPI9x+PtACf8WnXbp1v1m/PFG+A1LqR9QhDyOGsaWtQxaWpBeCcsTA2NClUzPwB4jCADZL5naUvCZmozy2306R20caTWrIYVNd4lGJjT9KzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvPnD3ET3IIZOXSOiEYXiFG9b0IYKAt0KE2DixnsSpI=;
 b=jQsoEvzQ1fqm0DtdkxkayRsyIVyoOF8Q8OXHdoIElLZmovHdqf3s8HsQUeRRznHieWJ/vTRx98E5AXqDQEsa4iRSrQug9DmdxdDa4zPvUPnXvYKFSHNUk0KNeqVoYyKebS60KKesMXSECyhuTmLzdG4rHxqA7ybW0YD5Qw5r4qsbNbMIMigztU9PNKojRk+UB6LvWsqNap8GZPchaU1JAbSXHzSRCM161fHf9ZW+mNOSPloxyoeTy5m6C7A6mf0n6kisVmwJwSC9adYZyBtTx0otTbJi+1oeuQEMhL5KiJ7psMW8iiUKFY4GBD8LcDRapXYmk4KNDyQLT0Pn2nFgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvPnD3ET3IIZOXSOiEYXiFG9b0IYKAt0KE2DixnsSpI=;
 b=kOuayo1mUHLVdcgIv4ovpQ3Ubk5UhCS2R4sggr5POShGki01qsMRdmwoi0NO8eqDJ+rFxWnzZuQbgryxCdbS1AuvkGnNd+MlzqfF2xwJv6IdeuWH4XCd75Ja1GGrxQEFovRpDR8UDZS8qqaEWRNT1wVMN5RP6A5YrSIExxapAMk=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:08:48 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::b) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:47 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:43 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 11/12] drm/amdgpu: implement SVM ioctl and fault
 handler
Date: Mon, 20 Apr 2026 20:07:38 +0800
Message-ID: <20260420120739.1811731-12-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420120739.1811731-1-honglei1.huang@amd.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa77abb-b357-4ac1-de57-08de9ed593c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6h21rx+L9xxI92bUheXS2hfp/hox+YCIloBsXnu1raIO4Pp1macYz7EB22cuX/Wupihbmm6VNFgS8phqlK7fhAqz+s6tT+ZErxP974VxzYSzWTdZDx7vzYIPkIvkfCaiCAvs/HTUK7inzF5bZEDfkvGs/xBJJf7FcuJpWyoiFfI5X+Wbpgh2hit/44gVC8L9hEmNeYrv4jI80m7XqBHdK/uiPhIDx5cI2s8Gq/wyii9v2U1o7b2VdbLWXWIqYCJrQIDsiyQWp4TOOdSr6R1xi4TyMKhYGl9dgqmsEd1H2XpG1QKYBTW3oOinX3IA0/IDyTLwO8/lDLi52MwJ6r3xLkAvjx9TJ7YPIu3KKY21UzZ6mWgrqnsr45/ZBo5Z9bGx2pp4i4zlsuUUezKfORWwYwhgRFnOoroiW4D8C6BlAUDaw4lWs8Tb0CBDOU3xgdAmNOyeR+cNsT3QDCCjiFgTGvHmSArYplGarfhgYRjSN+VPmrf1IfkGYurnbYdAnQxLbFRR1i8UdyGXXlaZY6MkYao48C25zouFoaWd5hkFeQMoZq1N9CKtJCoz1wcZIAyuLvMKtrsefkvK6yFlDASXkPdxam0HPdC0yQuUdSvwBW53jYifJqwKNXXK2MxoXGa9hQUH05NKOysA72fqLkJqP8ZxQ0uqfr/auCaxuoECwodRAfLujwRyfvXTQ0HDmQzBHy/8paLv4b3Yak0YnBjQZ4iiJaGNzwQYNI1slpKIq3YxsJAtgTHpk/BOKepkjvKOODW2oaUTr5MXCTteU6OoYDNuSjUPbjHwi9Afxj6JjHY9CTah4h/9nwmKiXWELMaX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ocWI3rVhAYUKwzjgo2iLoxFWznU0nb8zn2Sro/JkbINk0FSWvJaX//aGO83bogp6/Cshby2LcKPuhlgE/LIKHpk5tseH10v3nr08iiq6WWMQhew8lFQrJKwySPNZHdruAqwIwUnc9jwXNG1AT3R9yKZPzeH2zf8R08H7daAjoUDx80aokGK4o3VHCk4+YdY3lS7q6pBZoib19nQ2C14HopYzh79bUvcl5mW3FWLMHeV1XE9TuEztegyZ1OWuoXAGxFgkVFyqIevK6FIs3jeKiK0wZiA2kug7gAZmragGhiUkOvzqAZY0F1ms+AHRUhigC7zTjw0CEM46cKcdOeATmvDJ7ewEKao/afPTn95aNwDI/dNPgb9zv4bevUL4nsjJQb9CZ5N5/ANDJlNI9etbRjFhoZwGooKeHa6iGfPYg9aS6fWIj5lncl2Duu8We1xI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:47.6718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa77abb-b357-4ac1-de57-08de9ed593c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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

From: Honglei Huang <honghuan@amd.com>

Add the userspace and fault entry points for the SVM

- amdgpu_svm_lookup_by_pasid: look up SVM context from PASID via
  vm_manager.pasids xarray with kref protection for async safety
- amdgpu_gem_svm_ioctl: ioctl handler that copies attributes from
  userspace, validates page alignment and range, dispatches to
  set_attr or get_attr, and copies results back for GET operations
- amdgpu_svm_handle_fault: GPU page fault handler that looks up
  SVM by PASID, checks xnack and exiting state, then maps the
  faulting page range via the attribute tree under svm_lock

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c | 160 ++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index aa40e1126..57103a140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -89,6 +89,24 @@ static void amdgpu_svm_put(struct amdgpu_svm *svm)
 		kref_put(&svm->refcount, amdgpu_svm_release);
 }
 
+static struct amdgpu_svm *
+amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, uint32_t pasid)
+{
+	struct amdgpu_svm *svm = NULL;
+	struct amdgpu_vm *vm;
+	unsigned long irqflags;
+
+	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	if (vm && vm->svm) {
+		svm = vm->svm;
+		kref_get(&svm->refcount);
+	}
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+
+	return svm;
+}
+
 int amdgpu_svm_cache_init(void)
 {
 	int ret = 0;
@@ -121,6 +139,33 @@ void amdgpu_svm_cache_fini(void)
 	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_range_cache);
 }
 
+static int amdgpu_svm_set_attr(struct amdgpu_vm *vm,
+			      uint64_t start,
+			      uint64_t size,
+			      uint32_t nattr,
+			      const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = vm->svm;
+
+	/* cause drm_gpusvm_range_find_or_insert acquire the mmap_read lock
+	 * can not acquire the mmap lock in the entire time in ioctl
+	 * just flush the work to  reduce the probability of failure
+	 */
+	amdgpu_svm_range_sync_work(svm);
+
+	return amdgpu_svm_attr_set(svm->attr_tree, start, size, nattr,
+				   attrs);
+}
+
+static int amdgpu_svm_get_attr(struct amdgpu_vm *vm,
+			      uint64_t start,
+			      uint64_t size,
+			      uint32_t nattr,
+			      struct drm_amdgpu_svm_attribute *attrs)
+{
+	return amdgpu_svm_attr_get(vm->svm->attr_tree, start, size, nattr, attrs);
+}
+
 static bool amdgpu_svm_default_xnack_enabled(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
@@ -262,9 +307,124 @@ void amdgpu_svm_fini(struct amdgpu_vm *vm)
 	amdgpu_svm_put(svm);
 }
 
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
+			    uint64_t fault_addr, bool write_fault)
+{
+	struct amdgpu_svm *svm;
+	unsigned long fault_page;
+	int ret;
+
+	AMDGPU_SVM_TRACE("handle_fault enter: pasid=%u addr=0x%llx write=%d\n",
+			 pasid, fault_addr, write_fault ? 1 : 0);
+
+	svm = amdgpu_svm_lookup_by_pasid(adev, pasid);
+	if (!svm) {
+		AMDGPU_SVM_TRACE("handle_fault: pasid %u lookup failed\n", pasid);
+		return -EOPNOTSUPP;
+	}
+
+	AMDGPU_SVM_TRACE("handle_fault: pasid %u svm=%p exiting=%d xnack=%d\n",
+			 pasid, svm, atomic_read(&svm->exiting),
+			 svm->xnack_enabled ? 1 : 0);
+
+	if (atomic_read(&svm->exiting)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	if (!svm->xnack_enabled) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	fault_page = fault_addr >> PAGE_SHIFT;
+	AMDGPU_SVM_TRACE("handle_fault: map_attr page=0x%lx\n", fault_page);
+
+	down_write(&svm->svm_lock);
+	ret = amdgpu_svm_range_map_attr_ranges(svm, fault_page, fault_page);
+	up_write(&svm->svm_lock);
+
+	if (ret)
+		AMDGPU_SVM_TRACE("fault map failed: ret=%d addr=0x%llx write=%d\n",
+				 ret, fault_addr, write_fault ? 1 : 0);
+	else
+		AMDGPU_SVM_TRACE("fault map success: addr=0x%llx write=%d\n",
+				 fault_addr, write_fault ? 1 : 0);
+
+out:
+	AMDGPU_SVM_TRACE("handle_fault exit: pasid=%u addr=0x%llx ret=%d\n",
+			 pasid, fault_addr, ret);
+	amdgpu_svm_put(svm);
+	return ret;
+}
+
 bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
 {
 	return vm->svm != NULL;
 }
 
+static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
+					   struct drm_amdgpu_svm_attribute **attrs,
+					   size_t *size)
+{
+	if (!args->nattr || args->nattr > AMDGPU_SVM_MAX_ATTRS)
+		return -EINVAL;
+	if (!args->attrs_ptr)
+		return -EINVAL;
+
+	*size = args->nattr * sizeof(**attrs);
+	*attrs = memdup_user(u64_to_user_ptr(args->attrs_ptr), *size);
+
+	return PTR_ERR_OR_ZERO(*attrs);
+}
+
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct drm_amdgpu_gem_svm *args = data;
+	struct drm_amdgpu_svm_attribute *attrs = NULL;
+	struct amdgpu_vm *vm;
+	size_t attrs_size = 0;
+	int ret = 0;
+
+	AMDGPU_SVM_TRACE("ioctl op=%u va:[0x%llx-0x%llx)-0x%llx nattr=%u\n",
+			 args->operation, args->start_addr, args->start_addr + args->size,
+			 args->size, args->nattr);
+
+	vm = &fpriv->vm;
+	if (!amdgpu_svm_is_enabled(vm))
+		return -EOPNOTSUPP;
+
+	if ((args->start_addr & ~PAGE_MASK) || (args->size & ~PAGE_MASK))
+		return -EINVAL;
+
+	if (!args->start_addr || !args->size)
+		return -EINVAL;
+
+	ret = amdgpu_svm_copy_attrs(args, &attrs, &attrs_size);
+	if (ret)
+		return ret;
+
+	switch (args->operation) {
+	case AMDGPU_SVM_OP_SET_ATTR:
+		ret = amdgpu_svm_set_attr(vm, args->start_addr, args->size,
+					 args->nattr, attrs);
+		break;
+	case AMDGPU_SVM_OP_GET_ATTR:
+		ret = amdgpu_svm_get_attr(vm, args->start_addr, args->size,
+					 args->nattr, attrs);
+		if (!ret && copy_to_user(u64_to_user_ptr(args->attrs_ptr),
+					 attrs, attrs_size))
+			ret = -EFAULT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	kvfree(attrs);
+	return ret;
+}
+
 #endif /* CONFIG_DRM_AMDGPU_SVM */
-- 
2.34.1

