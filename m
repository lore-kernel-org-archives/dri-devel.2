Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636D606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aPWjaU0+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F406310E2A8;
	Tue, 17 Nov 2026 23:35:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D12310E68B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:35:02 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMfFCN1614080; Tue, 17 Nov 2026 23:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=i1VYgO20uHrJ5cjZxXyPYHNjUtb5Rhdp5GG
 Obc/wM+s=; b=aPWjaU0+hmIp8QK2ElH3YeQrhxS1eo0Ut7+00Ci0J2da6P4sjz1
 zIg6bGSW5cuufvuV1+Xh/vOv01XMZWYasSIhqXCmfbf3s9+gNjqma7Lf/zLNc4tp
 znspvhCazOwxaBsHYW8aHPt8EL8cb62WtpNBeKbLl8LMAjs/XiqxE/2P/jIA43me
 E7Fv8cNrXljPqwqSnD1ue2otgsNhxi4o/SdLCI1qtFZfPU5TUEz+mQ7qvcAt6ap6
 O40Hddd1d4bp4eessjtT787fNp+iUzSkpyEcRgJy/aAZZqP02mEJVIKp2ZKuarIp
 W97DoQ99dmmLwd3pm01KmdEqXrTaGJaefeQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8r68v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 23:34:52 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHNYp653484120; Tue, 17 Nov 2026 23:34:51 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AHNYp453484110
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 23:34:51 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id 3DC7E221A8; Tue, 17 Nov 2026 15:34:51 -0800 (PST)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v4 0/4] Extend drm_ras for qaic telemetry
Date: Tue, 17 Nov 2026 15:34:30 -0800
Message-ID: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: xJHEcGoMCwteZIZwrHKeeOGySt8bRWV6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MyBTYWx0ZWRfXyyt0Tga6T/O2
 3sXe940RzCt00ydmjsORaxsVARZXX3lzDd7sF6dm/O8e4HD8rbYoYGdlBTOuseFAN6yX9mNFe1B
 sNTY+eyNgSI6VZHa+VdXfSVcSqB2jYc=
X-Proofpoint-GUID: xJHEcGoMCwteZIZwrHKeeOGySt8bRWV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MyBTYWx0ZWRfX8JMUKRCXAAos
 q3g3sRMFtFaRmuhY5XZnjJYmyvHcrKNW9qEsw+fakXMkh6viWjYxNLVCUn+a7GqNapHJAWmRvpH
 0Pgp8wwGSUEUySqroSOESBgqTiwOg00REyN9JkHKFPARN2hFDQvUgjkoiEai4ko6R/XQROVJAws
 HZPuS4LuOcCYsYBSMgdisCZPj14wHYZtLY0s6JTtC1UYbuYBYqQmEW4wywf/Cle1O4KfKPMyqcM
 VvuXOlizreEwjFjcjMxYyPBzA2uBVYeDPLgq333kdOAEQbY2XVPZ0mPZ6KOt6F8H1YxSv0+vj6z
 WtTYu2HndMKX5AKIyMaT/6D2x/fN3fSqp05g+o/Ym89PozAAbqP+bP+o0g//G51F0cgifiEKuka
 g4Us+puw/O6Kr3U3TkSYVd+2NYO4gm+d9ftRO5IowtRAUnVtfypI/xcuFNwWNB0WAO2Z1mp381R
 s9um3pVRBytupm5Zq2g==
X-Authority-Analysis: v=2.4 cv=NNVAaE6g c=1 sm=1 tr=0 ts=6afce49c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GTUgH3iTEpiwU7-jJgcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170093
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series extends the drm_ras netlink interface to include a new
node type for telemetry nodes. Telemetry nodes support three operations:
getting, setting (optional), and listing telemetry fields. Drivers may
specify an optional predoit function to validate get and set operations.

Telemetry get operations take the drm_ras node id and telemetry field to
be read and return the field's value and any status reported by the driver.
Telemetry set operations take the node id, telemetry field, and value,
and return only the status reported by the driver.

Before adding telemetry nodes, a new patch is introduced to add refcounts
to drm_ras nodes stored in the xarray. This protects the nodes, which are
owned by the device, from being unregistered and freed in the middle of
a netlink doit such as getting an error counter.

This extension also removes the admin requirement on the list-nodes
operation. This allows drm_ras nodes to be discovered by userspace programs
for drivers that do not necessarily require admin privileges, like qaic.

The new drm_ras telemetry interface is implemented by the qaic driver,
which exposes the telemetry fields to userspace and enforces filesystem-
esque permission checks on telemetry operations in its telemetry_pre
callback.

Claude Opus 5.5 was used to assist in the development of these patches and
to address Sashiko feedback.

Changes in v4:
 - Add refcounts to track drm_ras node lifetimes.
 - Address Sashiko comments:
    - Fix status field population when HW returns an error.
    - Add refcounts for telemetry nodes.
    - Update outdated commit messages.
    - Add static to private functions in qaic_telemetry.c, and remove them
      from qaic_telemetry.h.
    - Stop returning remaining jiffies when device status is nonzero in
      telemetry_request().
    - Add mhi_unprepare_from_transfer if drm_ras node registration fails
      in qaic_telemetry_mhi_probe().
 - Consolidate get/set dumpits into a single dump operation.
 - Pin telemetry node to context in pre-doit and unpin in post-doit.
   This ensures the same node is used between pre-doit and doit calls.
 - Change field attribute to uint and status to sint.
 - Added NL_SET_BAD_ATTR calls to telemetry netlink functions.
 - Reject non-telemetry nodes in telemetry get/set/list-fields.
 - Updated qaic Kconfig to depend on DRM_RAS.

Link to v3: https://lore.kernel.org/all/20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com/#t

Changes in v3:
 - Address Sashiko comments:
    - Properly return status when telemetry request is successful but a
      hardware error occurs.
    - Validate telemetry fields against their gettable/settable fields
      lists when invoking the predoit.
    - Update documentation in include/drm/drm_ras.h.
    - Moved calls to qaic_drm_ras_register/unregister to mhi_probe/remove
      instead of pci_probe/remove.
    - Added srcu read locks around calls to telemetry_request() in get
      and set callbacks in qaic_telemetry.c.
    - Added a tele_ch check to telemetry_request().
    - Properly handle a -ERESTARTSYS return from
      wait_for_completion_interrputable in telemetry_request().
    - Ensure field can be truncated to a u8 in qaic's telemetry get and
      set callbacks.
 - Minor code cleanups (typos, header ordering, etc).

Link to v2: https://lore.kernel.org/all/20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com/

Changes in v2:
 - Address Sashiko comments:
    - Initialize certain stack variables in drm_ras.c.
    - Added attribute guards (GENL_REQ_ATTR_CHECK) in telemetry doits.
    - Added a valid node check in drm_ras_nl_pre_telemetry.
    - Fixed improper node callback in telemetry_set.
    - Now registering drm_ras node after MHI initialization.
    - Now removing drm_ras node before freeing MHI controller.
    - Added scoped_with_init_fs guard to qaic_telemetry_pre's inode check.
    - Fixed improper kfree in qaic_drm_ras_register_node.
 - Changed telemetry value attribute to sint and dropped padding attribute.
 - Updated documentation in drm_ras.yaml.
 - Renamed telemetry read/write to get/set.
 - Added dumpit for gettable and settable telemetry values.
 - Made telemetry_set optional and added admin-perm for it.
 - Specified ynl file regeneration in commit message for patch 2.

Link to v1: https://lore.kernel.org/all/20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com/

Zack McKevitt (4):
  drm/drm_ras: Reference-count nodes across netlink handlers
  drm/drm_ras: Remove admin-perm flag from list-nodes operation
  drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
  accel/qaic: Add callbacks for DRM RAS netlink telemetry

 Documentation/netlink/specs/drm_ras.yaml |  98 +++-
 drivers/accel/qaic/Kconfig               |   1 +
 drivers/accel/qaic/Makefile              |   1 +
 drivers/accel/qaic/qaic.h                |  19 +
 drivers/accel/qaic/qaic_drv.c            |  15 +
 drivers/accel/qaic/qaic_telemetry.c      | 563 +++++++++++++++++++++
 drivers/accel/qaic/qaic_telemetry.h      |  14 +
 drivers/gpu/drm/drm_ras.c                | 611 ++++++++++++++++++++---
 drivers/gpu/drm/drm_ras_nl.c             |  45 +-
 drivers/gpu/drm/drm_ras_nl.h             |  10 +
 include/drm/drm_ras.h                    |  98 ++++
 include/uapi/drm/drm_ras.h               |  29 +-
 include/uapi/drm/qaic_accel.h            |  28 ++
 13 files changed, 1461 insertions(+), 71 deletions(-)
 create mode 100644 drivers/accel/qaic/qaic_telemetry.c
 create mode 100644 drivers/accel/qaic/qaic_telemetry.h

-- 
2.43.0

