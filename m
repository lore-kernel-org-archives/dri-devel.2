Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDD1CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 06:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4D610F10A;
	Thu, 14 May 2026 06:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ght6Zgnw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZpEuJkQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9910810F10A
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:28:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E3c3jM3430137
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ihdQr/IQNRjruM/C0UDOVxKDfKTmzf/kZ6f
 pH7xLN+Y=; b=ght6ZgnwxHaE6wCqVOZuicIPZi0zKOXc00OXvM2ckqa4Il16QuN
 UyB30zPw/SGNFP7RfRO793C83PNsMHQHDQaBm9Mig4znJnrazpvgGVG4eGsWCGHW
 cKhEFvSjdaxjTqYKaqhrANiBc68bUmv8mfVsQek2O6UtPGzpPm4tWgdcfuoE3iba
 lMFmnnMh7VniF3dek6pbekMDpXLINW7zxORTib3XW97LLfYR9BBSVT5J3v38PnR4
 88BlydGemztRFRTf+WXuEM+aFRDS01OFZqYgShsXDFk331HFNZpj4rDpQ03cpkjw
 KPG7l7G+FtPUGdFlmMDGjaAj80WErdgpE2g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcky6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:28:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c827adbf00cso2631312a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 23:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778740115; x=1779344915;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ihdQr/IQNRjruM/C0UDOVxKDfKTmzf/kZ6fpH7xLN+Y=;
 b=WZpEuJkQfXXptDyBDGTKXl4uc7jQmNhpmcyxwgbwl6bGGXJSzufNt97evJevwBiWJN
 oI4WbspNULfcEG6wo0C8uau1Cxau4QJClkmCAhsPsfHUwXWtv0+ZBr8CcJtcy17sCRFS
 wU1EkrQ1cBond8WxsBlePC0zO+XAOuLv2MW383e30C5Rt5iCAmNG81onkQuhMs4WIcpS
 kSCq2m8sOwOyM3DNw4vs/Q2DBxwiqIpXbdckENi2qVnc77M2FJBYSSAnTtmeWG0oztKx
 82OxMGCJ6IweQop2MTZlV+us/M0Yhymg/FZkGpeCMJcNEArVMlP2cN9zMkTpNUG0TACe
 d/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778740115; x=1779344915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihdQr/IQNRjruM/C0UDOVxKDfKTmzf/kZ6fpH7xLN+Y=;
 b=QArJqG4kVfgy8JnIBBNnLKeaAgefJwEZjyupUM5CVzxhejNYPkfKd0dOlptiP37U9U
 BsvuGJydv+odPZV68c1ywcE+FJb9mYBky5tIaNcemKJ/yBLGWxqaWM5OVSGvQD2bRNdt
 6N6pcbypOVk/sc5wjEzkUnlb9fEkW32vqUIvDg8ycVFL1pmTnveBMeQa5CiRL7y/j3oS
 zGfsqElSVrKs+FkDAWspt7W3nJ3/uPmVgkR903d+bg/qe+BkhwEbUFr7qXQXVAf4kzyX
 lics0Lg2o3vTJ14RJ5vqw09U7/VzM0fq792yCdjxgWlPysk9dSqkWLLwdj6WydZgz+8N
 U6JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WBj65gsrKkCBHRoEBUfbarV+jHms0RgXY3n8KVA9O88EhDAYaQLDPr562ODaPNdIOHR4/kS4FYCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAq8vtIdaIpKP4GeVDeFKm+9bv6tUVafGrssTQeFLmbhl6oiQs
 uhSl0nWzkMLU12T2pVdr1GUvb7gRS/e7zUSl2wpB8H/sP5FaNiB7cy1I4WkNIuZQsWgVJFhvxQG
 24PvpqD4jO1knXH+Y+TCp21B5l/nyRIlzflACjO85gqk0USx7LKIDz4KKfIOIF4BmuVG/wfg=
X-Gm-Gg: Acq92OGp+k1qmeJAFyzOQJ/jlrRzeepsyGX/bMcAJmqoQKWf51eWb9Bi8U/jbQPT0Ps
 uJKkmJWBgOKmg+Hzqcqm6PdPJR1ErllBwjrxwLq3AQ5BpB1UGVgsmNoy7e+yoZjvmHoGf8ayjBY
 5IF+bMXQioYRwZkvtgodDtXe1WiELixA0XzE8q/AtmekywBoByZchtm0o5wzI8Mi7/Xi3s0XJIp
 zWP1mnnYobEkD3Y9y01VCTkXoxEvsABdrm3lU0mBQcBCKbNRQZ6FJxohs4VhAS3NaFQ+sg35ME4
 9x+b+N53xvYQoK9NzZbanC0t5Zs4FSlqSdrE/lM4EPpVT4Zgk5TkoTQEGGOBbRtlK5an9QAi6Rq
 rKiGaJPev48Xz7V4qF9Rf+P+iQswcoiv0xq1hTLTguph006eDvSdLZLXDF/LLyrEBwAE/iNNiJA
 8tLJs5M7/vadQieXAI17I=
X-Received: by 2002:a05:6a00:1acb:b0:83e:e03a:f926 with SMTP id
 d2e1a72fcca58-83f03e910e2mr6451209b3a.9.1778740114385; 
 Wed, 13 May 2026 23:28:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:1acb:b0:83e:e03a:f926 with SMTP id
 d2e1a72fcca58-83f03e910e2mr6451176b3a.9.1778740113707; 
 Wed, 13 May 2026 23:28:33 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f197995absm1434904b3a.27.2026.05.13.23.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 23:28:33 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com
Subject: [PATCH] fastrpc: Reduce log level for DSP info and reserved memory
 messages
Date: Thu, 14 May 2026 14:28:25 +0800
Message-Id: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: x6Bt9t7ikp2F6NyM9BuJnyvcz4SmnOSv
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a056b93 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=H3QoRsm3v3rqaJNjNxMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2MiBTYWx0ZWRfX3Yiexuf65O1n
 Kl5OkOAUKLad2/pmM0KmdH2gWjIb73u1Yi5PS9M9WqpueRHADoVfsQNgsLTcKAwDsTxysWeK2zo
 QcPu9LM1xWKmkje0zF2yhgcaXV64Xa6c7P7cXjPvoi1YGmd/FAnv/nTyDhWBT3aYs0Zn36NM62v
 PrdBUzz909gBIgR6AAMo/+P5jVgV0jIk/pb/ziVkxukhdcMgMROqQ6/dYGyh9y3/5dKEg8cG1CA
 4FIvheIgcg1E9QaqwifEraex9+l8Mcv/QqykPQLBkanaLaNn/J4voQohZBUSlbSoSAP/DpxxIAR
 EkFlHcgFxtCqiPswndzUIhVHfyfuJpBhuMTRYV25ROVxoWQOMhaZsq24MeRYn2FfB63JWjVCOyQ
 fsnQvN88O4E8sDi3KARZKwISEpiT8mLyxMpHL7V/r6VIEeDhSbgFxKz9uFZNhYqBngoKOHTBytE
 olg+4bNQMOeabV1vH5A==
X-Proofpoint-ORIG-GUID: x6Bt9t7ikp2F6NyM9BuJnyvcz4SmnOSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140062
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

On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
to retrieve DSP attributes during boot, resulting in repeated
"Error: dsp information is incorrect" messages printed on the
console.

These messages are observed continuously during boot when metadata
flashing is enabled as part of RC releases, causing unnecessary
log noise.

Similarly, the absence of reserved DMA memory is a valid
configuration and does not represent an error condition.

Since these scenarios are expected and do not indicate a failure,
downgrade the log level from dev_err/dev_info to dev_dbg to avoid
flooding the console.

No functional change intended.

Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..05ec14c07fd0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1802,7 +1802,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 		kfree(dsp_attributes);
 		return -EOPNOTSUPP;
 	} else if (err) {
-		dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
+		dev_dbg(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
 		kfree(dsp_attributes);
 		return err;
 	}
@@ -2361,7 +2361,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	}
 
 	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
-		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
+		dev_dbg(rdev, "no reserved DMA memory for FASTRPC\n");
 
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
 				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
-- 
2.43.0

