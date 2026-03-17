Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67364FD8740
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D277910E610;
	Tue, 17 Mar 2026 11:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y4kubY4t";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08AA10E60C;
 Tue, 17 Mar 2026 11:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMx5t4RPlq9zGa+7gCrLrINmn/kzeY86tqdnXrx81wY8L+rsqLRdQfXKcCTy+0eOZG4qmA4nosbDzvH23ZtTCNaSNp20+pzEGW2KCp7jrTpYCICL58EBQPCkSS9BJbnSofoG7P8Bm65W2Dus4rlm1mi3oyTD8lFkVQn97WUs3S/TBBV27RUwONL3nMMJvlCnKxiW7fksoy51ZBiAMQ/qFRMefbOFXOfHQpV968Si+W6WaPrbzMAV2EhU5bCBxJCHMqUck0RidX7fzVEv77lVL3P0/rud16TsacVtzuGPO459o+CCPdpTP+9Wbm8fUlOjIlA84wIjngKzPAWCOYztNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvPnD3ET3IIZOXSOiEYXiFG9b0IYKAt0KE2DixnsSpI=;
 b=D16XvVtOKtLL8yERj8PPwe6xfwb1tfXVV0BUxYBvBbVK8D1wTHTHxg3cZKAyTkowe7dxwFCkwTD87VGo4JvIlRwpKTM+RFx1X4Fq27sgRyjZJrhzqaIamB7QSwlB+6YXIZmI9ZMM1gaCDPGVUQi5rKKsnSSZNVhysR0YGRFo84W3sS8ydBPiHCCrT8cWldFgN/sFGm/NmlQq2mdhcByBKxcl82HjkAWJfQcB8BLLsbNyrARCHNhkozb0C9jdrLKdoYv706vrByTSg4TyBVjX87RhJmeHDsP+h3xhoHlOb2IZUwt4MMSllamWvXl2AibYhFaQGfBs9xPauK9Z1J2ioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvPnD3ET3IIZOXSOiEYXiFG9b0IYKAt0KE2DixnsSpI=;
 b=Y4kubY4t2u+KKfvkIP4lwXZNO5uL/nIcO3Vp93VV0lx5vYqWp4PTje43uJiayGOhA64bQazUxgONSagIas3RX8GwZ/+CZ60n/nFE27Lto9Gn8FkwHHa9mcsxZtZaJ2McsZXMplCNbzad91TAUJuyEOll8gFPfcWMJST4f5Pl8HI=
Received: from SJ0PR13CA0125.namprd13.prod.outlook.com (2603:10b6:a03:2c6::10)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 11:30:51 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::fe) by SJ0PR13CA0125.outlook.office365.com
 (2603:10b6:a03:2c6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 11:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:51 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:47 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 11/12] drm/amdgpu: implement SVM ioctl and fault
 handler
Date: Tue, 17 Mar 2026 19:29:57 +0800
Message-ID: <20260317112958.2925370-12-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317112958.2925370-1-honglei1.huang@amd.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 562e6183-d6a8-4bd7-94f3-08de8418a4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 8PR+rneNNreRaxEqvoJ6u71BRl74qZh0pc+8S6zDaa4L6zYNJkSXAW7J8iM/X3gTNjRq2qrmJUJflJaUooDubCnwht6YwMqvXNVVAxLptDCmKQ9zm2ApWZmZfnMmVs4GFjCx+vfWJn2UoBTZtJmkCTXlI5NkWo6oXlGx2BeZU9cUk+NaNEAckyNPdso0NED2XeJ48jSp4skuZQ34U8LENE847wXydhLrRzUuZQHCVTMvAhxEdsiAcTPfjsLwmaslOoLIvlfQUfk8wMEflHEw0UNoYSv3RAYWfPvxwyTH/+NTMKeP0hZo88MFRA4JxiNBRjw4O4lo79indPSUQkateEKlWcPFZgq/Re5clDFDpN9RusVitsrnn3THiK07q3+h75f7jvWsMH9ApkcwriPQ1aaNH5izLej3cgweIHrZz+mi9dc/DePZceOoNjZ51LQSx7lvgur2skNond8HTXR1icaR0OrUHB63WwWpbqmaCTdBJz6NShRCCnjY4nz5CgGXtPtGTznw0aiGF/3v3YrVB1sEh2UhnlHjWqu8BG2DFKJknSDE5NH/mVfkFGtDogKcOsJjNAaiNPNdl78CiNDJpqPlCaSycbcikyNd8sCRKSfOw0+N7LjiFIWaQFvtCuXuWe/ErxJtIP2l+mYVPpPc90pCTxp30eR4AQXdX8wrpNZWHlqqdzGePPtuRErqIhQ7oat+3w33aoUIif2sATcAuPrjqkdx1gjomTkiQqyG5EoXkyfh/zpo4KiAOkD2svJrT0WRFjXdnmHCjdChV+0xB4U8ME4UKQrMFpGc0Nc2/0gDTtlhP5+VFZrEqDsxgZ+J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VqSKGbapx+yRAdt/gwJ5yJYJkc1c8fZF+Rb5OyLxr7QJinjgMB4EsTFZIXiJvC4iRXZ7XotdKUYQMFRgfXK4EDpnliUn1EnzTrWd4sNxqxD2lYntnzultXs1g+6PpSl4c5BBkqhJuV1QG9H25N7HdXsdAcg3Aopaoh+5/iLLNDtxlhnPZNfC5zYX3S8EIgdn4dOW5gm5M+ukiRtolO/hNwYfPdRr8oQa1dVv5TQFIoiRreCKpEPdGfMDLuCrQLTdjPWnLQIScOdR2a/yfSRXLFukU9ofU6DboL2iCr/lFkR5IHVq5dn///oXUDiG4KftBQiHbD7GMK8DIwwdL69DUrCs3D1Z/9r4Q76Bt84+FdBfRCZNFwYFJNJnhNo/MG2Q0WVjwc+hD+Rj1qRsT6G/SXpsDEyESRTbOPmp7X6XpBVU9w6OZcrb28YoACyuaoNQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:51.3745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562e6183-d6a8-4bd7-94f3-08de8418a4f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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

