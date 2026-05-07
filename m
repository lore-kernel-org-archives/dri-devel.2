Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65225CD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C171E10E1AD;
	Thu,  7 May 2026 06:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OlstpMot";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BNu8Nqdh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D2510E1AD
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:23:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64760u903036585
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fKKG+GaCcws
 0o/B+y8TpDjd62UuzsjpXKuwFWrqTOkw=; b=OlstpMotKKRmmTs2LftnJBMlcyz
 Lx63aETl05jFkKgWKv6Nj+NJMlWQC72VN9PoVYfsy/Xk51G+ywiW04n3/N5CrWh4
 bBlpDZcjZWTXLBm/T761+mZ5imxol6QpvT6hO2JMjLIB/eLXXfjPdAPV6IT7C5Cm
 Esk+ubuI6T5J8LTz0sAwZ4MSQa7+ItXh9BuPnAaOjLTb4ho/7bzgzUYnLa+3iz+c
 aH5NMUxIirZVU+j/0mm2Hut3mhvet58GI7GaaxiYZGQoT5rTGGDBdxA0xsibi1eO
 5rzoaHKl7O+co+KNlmut7z+JDuy7IWPkG4TUjV5SreHIuyQghvrCyJUbPzw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf3ge9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:22:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa5ecd760so267685b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778134978; x=1778739778;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKKG+GaCcws0o/B+y8TpDjd62UuzsjpXKuwFWrqTOkw=;
 b=BNu8Nqdh43J47mEAmLbBGm+7njAbgA/7RuCvZM939ilC84GYA5gdDgP80A6D6q1OvG
 Orir5av5rPycv1J68Wl1x9N7Y2KLISYUJQgtL26VSpsq6JnEbxhS4rXLi3ycp8qXQXnc
 0M/lIY/MEDSH33OWhJO8AGX9yIzLQTOuh4JOSvAmnjXb7WfvVV6j6U8mDUAbQ5h8mUSs
 rsqNXIFrdV2BaaO44KtIl10qpRKrKwmjN5Ij4qb4i/7caimDu1dYCI+nVIrodzd4x/tR
 W2WYxP5ihDnJ6E76ZGcT3PFgqILGTxo7ERZPnz6WiMgnGRDuHb2epKOOkfv1QpTWyALF
 NHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134978; x=1778739778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fKKG+GaCcws0o/B+y8TpDjd62UuzsjpXKuwFWrqTOkw=;
 b=qd8F/jsaByHIcW4XpUU1g660gZf8+8XaUcJC6AiuecZXDMFs6keMDmqOBBIaxtAh01
 Ah+ggLHCp3T/gxML1LtlvEUuAepa6TaeJFSkjedoga0ia7PpwqoMJewVMNr2jLwsYDek
 7zDwsXmmTDeIdrfFkDe6UKLeWc0GUKi8k2f7bEOZi6k9p4lWw+Hldr2f+/zxxERex7x7
 sEOx8mN6Y75TtynO8aUOOpHkNn6LP+CwRNRf7tOwXbo5HmFZ5KNzN4Kn08AJSzeUQtvw
 s7fV8r1LJA4Kz2ilBFsER20AnUCOhy9Z+P7geB72Kg+r3JUSfpx7KD4YGRUW/uKPDZir
 G8WQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GrfMQj/pUoapPTC6vVBbRmYWV1MnMq7JCQskqAGRuWbrLiT/iFvSARbFEDkv6OuszduGdV7qwoVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1SU6qJ6aDb+5rH+2RpwphJD+Ssouhq1wBMqE8NE+c9NDdhbk+
 C2EaR5Z3Ymk7uV5Gu82BhjQM/dpRkjrfE/4fzlwbtZAdvDHKLlz0ZoQBJ4TE9vkarpTalq3RO1c
 Zi4yk6nypqro1gh4g9t/oe6hnl1OwFaHE+1OcRDfURn338hV70wlmSBPbazRhx1ibeuUp0iM=
X-Gm-Gg: AeBDievqWijM8xCP+oRaiZATlRWMozubRCzrdr7+4E/LL8QHBO+/Q4kFP2F7ynzJzWk
 HTkrNv1bNiIBvH4gn93S23UCM/wKMXTsLaGsVMstj10A18vaQCGtw5LsLr35XWyoT3X4FSnwwRl
 i3GM1JLQErNh9bVH1cC2B8mfg1/ylnAYmSvQ/ovqBBUIT6Bq/aulwI9I/02TJQH+aNHQXzA3aYC
 6vw1MlHLiNMWstDxcHGUTXGZtHSR6Gq8qS8F9FUU5qc/hvdJTAxqurm19uF6yv/YO/3vfzjlb05
 i/uM2bCuRDCv6Petr77g9jdhRgYOjfTsXKnXQRq10mTjMiYeijuLTe/OFxPOZXLzLCuurUbO35l
 EXVrxZ0pbR2vg3XKZbJmMEVC2XbFRf94PYlmWCDNMnDB7zy/ZJmSHvjp1KnoitkMIPlANETXf3v
 fGtOP2PNSHcJ0xLljw24HRoy8Ydq6wN1SWnwl8/XoyIliREwE=
X-Received: by 2002:a05:6a00:1411:b0:838:c01a:7a50 with SMTP id
 d2e1a72fcca58-83a5d68134fmr6288259b3a.30.1778134977945; 
 Wed, 06 May 2026 23:22:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:1411:b0:838:c01a:7a50 with SMTP id
 d2e1a72fcca58-83a5d68134fmr6288208b3a.30.1778134977319; 
 Wed, 06 May 2026 23:22:57 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:22:56 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 1/8] firmware: arm_scmi: Add QCOM Generic Vendor Protocol
 documentation
Date: Thu,  7 May 2026 11:52:30 +0530
Message-Id: <20260507062237.78051-2-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfX3Tk1y9F2D7PY
 n5RrnYf+wL5PXulQvyNJ1RU4AfPGw64FrqIG676OECo8v+D5OONl+g0i+3hnddXLlHY9ozrkkei
 rclpIsxvkZc7zhF2KGsZVEXgvmFctPuNkoWiJJ5/tjQHolQw8hn/ajPzJWQxsmpwbzT3Y4fokx8
 5N/VjuWSGkCfxFqOrxfZgSSqW2eHFahNcRIHbHUZMyZkEMfpVrXMzb6GcJUmdH98g+qaOHm2sHB
 /Ja5YQI/2DlzQUK7zzCXo/WS1NmfTi5ct38H/v3J1R8NJ0ufMI3uABAUaglY9diXQ9zfH6Ussjf
 w08LzJ+Lzm+1FDoKDw2Yc593BuB6UzDAw1JI3XpsaMKZFz1LDFdacrjDMPHwlJAKd+uWh+Pl/DB
 /j4Po5AgqMADOtZTna4WF5z+/jzjVJtqeHkzE19hLmufOVnEY9Xv7yaV5L61pn2L238TNZgGcoa
 g42DCBWXHcU7XNXntzQ==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fc2fc3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=fRH0SyXitDLK6ufOgm8A:9 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FOvD5j_M4w6AwVWkhifwrxEVTJ0czKOt
X-Proofpoint-ORIG-GUID: FOvD5j_M4w6AwVWkhifwrxEVTJ0czKOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070060
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

Add QCOM System Control Management Interface (SCMI) Generic Vendor
Extensions Protocol documentation.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

@Sudeep/@Christian, Just moving the series back in RFC mode to get feedback
on the devfreq part of the series. Will add a lot more documentation in the
next re-spin, so definitely not ignoring your earlier comments :).

 .../arm_scmi/vendors/qcom/qcom_generic.rst    | 211 ++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst

diff --git a/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst b/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst
new file mode 100644
index 000000000000..141bc932e30f
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst
@@ -0,0 +1,211 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===============================================================================
+QCOM System Control and Management Interface(SCMI) Vendor Protocols Extension
+===============================================================================
+
+:Copyright: |copy| 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+
+:Author: Sibi Sankar <quic_sibis@quicinc.com>
+
+SCMI_GENERIC: System Control and Management Interface QCOM Generic Vendor Protocol
+==================================================================================
+
+This protocol is intended as a generic way of exposing a number of Qualcomm
+SoC specific features through a mixture of pre-determined algorithm string and
+param_id pairs hosted on the SCMI controller. It implements an interface compliant
+with the Arm SCMI Specification with additional vendor specific commands as
+detailed below.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x80
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   |See ARM SCMI Specification for status code definitions.       |
++---------------+--------------------------------------------------------------+
+|uint32 version |For this revision of the specification, this value must be    |
+|               |0x10000.                                                      |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x80
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |See ARM SCMI Specification for status code definitions.    |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Bits[31:16] Reserved, must be to 0.                        |
+|                  |Bits[15:8] Number of agents in the system                  |
+|                  |Bits[7:0] Number of vendor protocols in the system         |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x80
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |See ARM SCMI Specification for status code definitions.    |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |For all message id's the parameter has a value of 0.       |
++------------------+-----------------------------------------------------------+
+
+QCOM_SCMI_SET_PARAM
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 ext_id     |Reserved, must be zero.                                    |
++------------------+-----------------------------------------------------------+
+|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 param_id   |Serves as the token message id for the algorithm string    |
+|                  |and is used to set various parameters supported by it.     |
++------------------+-----------------------------------------------------------+
+|uint32 buf[]      |Serves as the payload for the specified param_id and       |
+|                  |algorithm string pair.                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the param_id and buf[] is parsed successfully  |
+|                  |by the chosen algorithm string.                            |
+|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
+|                  |matches.                                                   |
+|                  |INVALID_PARAMETERS: if the param_id and the buf[] passed   |
+|                  |is rejected by the algorithm string.                       |
++------------------+-----------------------------------------------------------+
+
+QCOM_SCMI_GET_PARAM
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x11
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 ext_id     |Reserved, must be zero.                                    |
++------------------+-----------------------------------------------------------+
+|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 param_id   |Serves as the token message id for the algorithm string.   |
++------------------+-----------------------------------------------------------+
+|uint32 buf[]      |Serves as the payload and store of value for the specified |
+|                  |param_id and algorithm string pair.                        |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the param_id and buf[] is parsed successfully  |
+|                  |by the chosen algorithm string and the result is copied    |
+|                  |into buf[].                                                |
+|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
+|                  |matches.                                                   |
+|                  |INVALID_PARAMETERS: if the param_id and the buf[] passed   |
+|                  |is rejected by the algorithm string.                       |
++------------------+-----------------------------------------------------------+
+
+QCOM_SCMI_START_ACTIVITY
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x12
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 ext_id     |Reserved, must be zero.                                    |
++------------------+-----------------------------------------------------------+
+|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 param_id   |Serves as the token message id for the algorithm string    |
+|                  |and is generally used to start the activity performed by   |
+|                  |the algorithm string.                                      |
++------------------+-----------------------------------------------------------+
+|uint32 buf[]      |Serves as the payload for the specified param_id and       |
+|                  |algorithm string pair.                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the activity performed by the algorithm string |
+|                  |starts successfully.                                       |
+|                  |NOT_SUPPORTED: if the algorithm string does not have any.  |
+|                  |matches or if the activity is already running.             |
++------------------+-----------------------------------------------------------+
+
+QCOM_SCMI_STOP_ACTIVITY
+~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x13
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 ext_id     |Reserved, must be zero.                                    |
++------------------+-----------------------------------------------------------+
+|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
++------------------+-----------------------------------------------------------+
+|uint32 param_id   |Serves as the token message id for the algorithm string    |
+|                  |and is generally used to stop the activity performed by    |
+|                  |the algorithm string.                                      |
++------------------+-----------------------------------------------------------+
+|uint32 buf[]      |Serves as the payload for the specified param_id and       |
+|                  |algorithm string pair.                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the activity performed by the algorithm string |
+|                  |stops successfully.                                        |
+|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
+|                  |matches or if the activity isn't running.                  |
++------------------+-----------------------------------------------------------+
-- 
2.34.1

