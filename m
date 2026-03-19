Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE471075261
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3C210E876;
	Thu, 19 Mar 2026 06:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XjdYOj6Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SRzAAea+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C853F10E878
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5XIXE3573643
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AhZtQR443/E19GewAj1186Zwj+uyAl6zxJPtQ9r8Toc=; b=XjdYOj6ZySs+ffOQ
 nIXhwt5OeOeWVukqAGGFaWFnkYi1qnr565OZs+NKGzUFqDEEMmFMAPrgo4nld+DW
 Ip9FlKU2r1dwY1+JHnFUeDSH1RF9RnqLCKQfLnhYNSfW7F79oYWtJ5S/GvurHkRQ
 Br9J39bODzuBspngARD1uc53SXDHWMGl7sEGOeX7vRsccZs9uYSQva52f6XysenQ
 Of6izH1A8FoqhEg1sFg39oPMc9xKwg4JVW6eU5OWbqGpP7AMcMGgculpSra5MXcY
 3JRWd30EVQF3SI4d/t9bsIwgr830exrO5qD65OmraYUqzUgeO1N1rC8L915SIl4G
 RwUmsQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r8nf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b061868724so49237425ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901947; x=1774506747;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AhZtQR443/E19GewAj1186Zwj+uyAl6zxJPtQ9r8Toc=;
 b=SRzAAea+Qhv7Wvk+n5dNWbqeh6+yiiKg2BMdTcG4VjDfLGQwyUqIdoJGlowH+submC
 5xldVsbo1NQH74cJ+fIiO+3kmw3s0lb3weN4OrIQepABw/7KddNlAp6Bz2FI3/ObhLHR
 o2Y/8wdnpvdH6nPLcPg6PczuQUHGXdI5/wd/G3l4Q654Da7lMzRZzbPm2h0rhCffFRBG
 egLRRfRCWYyQcx4z5BsQu+ANgxQTUPSD7/jtscm+MP2zuqEXDj/z71H/ZWZANpXAEn24
 zaghcZ+/ESIipO9i2wKec5AgVbrPBs5WBPmH801CmKnmgISQfTlBvo4Tqko6Vg6BtlRC
 R5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901947; x=1774506747;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AhZtQR443/E19GewAj1186Zwj+uyAl6zxJPtQ9r8Toc=;
 b=DJ60znVBsCRY1ewhSuh8DlraRrPnFfKcy54UjrHWxBHCkVEoAaEioRXXJ2IyRUtiAG
 xDfWvpfP4HNPGen0tFLAjsA7wFez9lYDE0AnDDdRfYNMviL9kSbFCQtsx6d+1I+z0/JJ
 GhdOqn1DCYsJ17a92+lNAWAKCJjj44M5LFYI684uD/+BY0+5hBFQ8Vgv+nnFl/Cl39Kw
 JTGN9EIxA64SdCu66pkeq+XaqluEnj8D+F0SWpYwvKwIbSJcUFx8UCpgWiRIou/EgRlz
 6g4Abet2TLAOIIBHmxeFHCt5kPQYFiTaXWIG8gTRivkEjZf7p3/snJL6+KcYP1d3kViH
 Uxyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrfsv0RhoYMBg4677xkfsUI+UVlW6dTAzWmYvy/GeWsVNSF7Rn7tmoQqDraAPStg77I8Yvu2lFh1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxY66ewwGPiuWIfguGnvDHEL1E/Ij2cgYqY3oATTFkY+zFv/Awv
 kQDhZaqNnC/WS3yik/qNWzWSo5hExB+M2anmIZCfIgiKHsNl033tMVrNqadYjsvebVSYXaNerqA
 W/NHnrSSGz2aj91wRSUrjzdxQxw9x3kd4bDAzNeO7/TUa8GvwSiaIwHgPypOCbkB7nEO8hOY=
X-Gm-Gg: ATEYQzyv7YH6MbRepAWW9rpR/gh2v3xpLh0Y99uCVfmqV6BBizV91BgXmrN0qTBuhVc
 a4APjSpxBfaHiNQk0tZP6d74wdW08BWVuUD/vmIdPr140xvTXUepIvvgjE7KEC//+4gEHMjXTzR
 NMMD1eeOIdHYBZAU+CHORlYkYIOTSUg0HEhVwClAwnEnC2skvG/0cjcjFBKGmFx0zXVRks8aY9+
 wt53fYC/6HAFhsuLJ9QJjbKmny87R93NwLQDc7vHAHKVKWei4W2JOELEHDsSuae0lvgiJwtTy7L
 qNr5stsNl4bWAaHrfXy5lG4ibOZTyvGSWFpj3L/m0aT6xdNdmqueEqRr6QelMXjAhPsTRuKGVoL
 9adX/EHucqiQRDFsgdbipZPItbdpC/fk1ikAoFMphYuv22JDxdvE=
X-Received: by 2002:a17:903:2a8b:b0:2ae:5776:45f8 with SMTP id
 d9443c01a7336-2b06e3236d0mr66217325ad.3.1773901946585; 
 Wed, 18 Mar 2026 23:32:26 -0700 (PDT)
X-Received: by 2002:a17:903:2a8b:b0:2ae:5776:45f8 with SMTP id
 d9443c01a7336-2b06e3236d0mr66216985ad.3.1773901946126; 
 Wed, 18 Mar 2026 23:32:26 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:32:25 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:01:49 +0530
Subject: [PATCH v4 9/9] Documentation: ABI: Add sysfs ABI documentation for
 DDR training data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sahara_protocol_new_v2-v4-9-47ad79308762@oss.qualcomm.com>
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=1903;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=PYlMjATY4SM1+jaLjbUMOn336QEIJpGFcRpjUcyzz/4=;
 b=oDJdabj+nevZsLKRAXC74rtzAHVO/YwH4bO6LZREstgcBsTlP0qNzP0ID0HAYGXuCGebsRFDN
 Qk9A9oeSuz4B1G+ilAYFW3ypjpCNAaWqO0Yl/9a3wvCY/fV+jBI0yuO
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: cjhhU5I_ujv5tBAZIGuhsa3R3fuuFeQ6
X-Proofpoint-ORIG-GUID: cjhhU5I_ujv5tBAZIGuhsa3R3fuuFeQ6
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bb987b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=dkV1H7vRkoxx0F9zaYgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfX42N41+d0Mm29
 kID0PEwcNiqmj1hlz68UD7Lfgf6+V/Fhj3mUXyVsC1EAtR9oAY9gEKCB70ms5v6VYO/oPPRlr7A
 ocvfKeAOKiuieOKS9FFgiHgbOR0F1J7NeT01ngUf7PK1YsqyUrT2woyydQYCBWfm6BO4aGQghq0
 GQNIGh2/go7SBh0n4q7ZM5ia0rUV8ivjpzO+vqPJl84bDYjangNrbOE/d2c2DF3Ci+VeoZ3GO24
 r4s8WECGN7sHXisWgYyxxHQZB9DA/q+ICIGXNQvMjx9wwBgz/kNkBuDiQs5+exJPfcWgmXfI0xz
 6k1NeYd7hFfeioED+mMGoh59YyKlVqIB3TmjjE+izF6fA32z8v0mqdLtIuOlkbzzIXJP1OEtXph
 OwPYTy7WkTA9KAcd7eOi3AsKk4brLMIwD9BR8HgT7fcf03NAOG/cYUqSoT84TxC8YR5dqlSBvyq
 bm4KqvlXXHqU8h3A3XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190049
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

Add ABI documentation for the DDR training data sysfs attribute exposed by
the sahara MHI driver.

The documented sysfs node provides read-only access to the DDR training
data captured during sahara command mode and exposed via the MHI
controller device. This allows userspace to read the training data and
manage it as needed outside the kernel.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 .../ABI/testing/sysfs-bus-mhi-ddr_training_data       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
new file mode 100644
index 0000000000000000000000000000000000000000..810b487b5a5fdba133d81255f9879844e3938a10
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
@@ -0,0 +1,19 @@
+What:                   /sys/bus/mhi/devices/<mhi-cntrl>/ddr_training_data
+
+Date:                   March 2026
+
+Contact:                Kishore Batta <kishore.batta@oss.qualcomm.com>
+
+Description:            Contains the DDR training data for the Qualcomm device
+                        connected. MHI driver populates different controller
+                        nodes for each device. The DDR training data is exposed
+                        to userspace to read and save the training data file to
+                        the filesystem. In the subsequent boot up of the device,
+                        the training data is restored from host to device
+                        optimizing the boot up time of the device.
+
+Usage:                  Example for reading DDR training data:
+                        cat /sys/bus/mhi/devices/mhi0/ddr_training_data
+
+Permissions:            The file permissions are set to 0444 allowing read
+                        access.

-- 
2.34.1

