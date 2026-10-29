Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E49606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UaBr6ipL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4378D11251B;
	Thu, 29 Oct 2026 20:30:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA7E10E1A4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:30:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJk3fB532607; Thu, 29 Oct 2026 20:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=lJlWwCF0XyB1DfxVENHzWSKFDxTRp/SQUcI
 9eHBpAR8=; b=UaBr6ipLGXxkBcxhaZdJJVzVLk7vqU4pui1vGmv0i2TsOJ7AXjU
 MnH6NpR6o3QAnKxfOQaawJ2cQH4z8TuU+za0hqIci5HHi0ORdCKOHVfdcbxmwGHH
 WoW4NI0Oo/zhYJo/3GRShIexpiqKjEzHOyQunz8PSmc1AuK3U45/5vScwBnP32aF
 VsOSP71FvrBb9HkzTYhfH38961gWArYDv2r8YJ3Rp5M/ck0iIj/sNRZNwFD9DR4n
 byUNoRV/ZeYMwjxqJtxmGxGFKr6vlZQVLJ3L2OJCu7l4ggzO909o20AvfQAurQ+a
 f0vxm+YdsvxcEzX1LiAzVHBIXzVtXHqxpYg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0rwsy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TKUEZs2780797; Thu, 29 Oct 2026 20:30:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69TKUD9D2780768
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id CC21122A85; Thu, 29 Oct 2026 13:30:13 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Extend drm_ras for qaic telemetry
Date: Thu, 29 Oct 2026 13:29:57 -0700
Message-ID: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: rIOgIKG7ivi_7Ywg7B2TbNtlZ2ckagrH
X-Proofpoint-GUID: rIOgIKG7ivi_7Ywg7B2TbNtlZ2ckagrH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfX9vNzxuI7iuJp
 nFjkjwnfO6wx8I+5SUv2fmeK300fbXWkZ2zMjSnZ92ELJYAWV0Kcpj03ssEzLNIaOL4L5PkZoko
 2idE5GHB7+JPgjfqnvo0Vy5WMnVIRzI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfXyU3oXZibil58
 y6jBqve+tHZ7bLrvNv/LHgGk05VDnQ75Fhtgn9kugbWPMi30NYdA5emex9dfHS4fbhjhmhOpOJT
 eFA3aY9+CQUOe5tZ7zAZGVdFune8sDPCiDkvuFcfgfgAlieIx0nFyA8xs5kxmM6ajhfuJ+ezwQi
 YYIFZGuhxo6yzBtGs5c7zO/yIrmAmCvtNE+QpscxOU67z0OVAmksH0Ggfxtm0GtW94NiYkeElXB
 Shs8FZR+JJ62rmqGzMhOsDdwcoh0hLBO3uMPSCkdOCMfOBN6EsDRijIroB3wfGrnBFV04vtZE+4
 cPnWZOoYmkjbZtblSHOnBI97k2fUOymlBpwhFWhm2MquwEZmbUl63u/uR6hLZVsFQdxADgXaqiA
 QsEgyjaAhvML0GKjEFH8fiN8W34f49ZWchuPTgoQJpcZXcq9uYMSglsPqyeE431csWT7fbSOw5Q
 Hh9/s/N9NX/x08qLC9Q==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae3acd7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KPAaMepPZ1nUKEOFJYwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290080
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
node type for telemetry nodes. Telemetry nodes support two operations,
getting and setting, and drivers may specify an optional predoit function
to validate each operation.

Telemetry get operations take the drm_ras node id and telemetry field to
be read and return the field's value and any status reported by the driver.
Telemetry set operations take the node id, telemetry field, and value,
and return only the status reported by the driver.

This extension removes the admin requirement on the list-nodes operation.
This allows drm_ras nodes to be discovered by userspace programs for
drivers that do not necessarily require admin privileges, like qaic.

The new drm_ras telemetry interface is implemented by the qaic driver,
which exposes the telemetry fields to userspace and enforces filesystem-
esque permission checks on telemetry operations in its telemetry_pre
callback.

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

Zack McKevitt (3):
  drm/drm_ras: Remove admin-perm flag from list-nodes operation
  drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
  accel/qaic: Add callbacks for DRM RAS netlink telemetry

 Documentation/netlink/specs/drm_ras.yaml |  83 +++-
 drivers/accel/qaic/Makefile              |   1 +
 drivers/accel/qaic/qaic.h                |  19 +
 drivers/accel/qaic/qaic_drv.c            |  22 +
 drivers/accel/qaic/qaic_telemetry.c      | 513 +++++++++++++++++++++++
 drivers/accel/qaic/qaic_telemetry.h      |  18 +
 drivers/gpu/drm/drm_ras.c                | 310 +++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  55 ++-
 drivers/gpu/drm/drm_ras_nl.h             |   9 +
 include/drm/drm_ras.h                    |  57 +++
 include/uapi/drm/drm_ras.h               |  19 +-
 include/uapi/drm/qaic_accel.h            |  28 ++
 12 files changed, 1117 insertions(+), 17 deletions(-)
 create mode 100644 drivers/accel/qaic/qaic_telemetry.c
 create mode 100644 drivers/accel/qaic/qaic_telemetry.h

-- 
2.43.0

