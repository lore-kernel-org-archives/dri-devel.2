Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9264DCD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DAF10E594;
	Thu,  7 May 2026 06:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cbc5IjMH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JhXqEDTm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827EC10E594
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:23:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6473eVFr026485
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=i9uWI5/lasx
 6W7TVmUmXkz+IrOXTCg+uMGmg+AQA+9o=; b=Cbc5IjMHJHhLGoNEo+vRevkBn4/
 o4Kwq/6NgQfNjIi5b/PX+3DG6j2BHNDpNVMhhinPqKmd3d/Ts2UeKdelMEPPZ15z
 tqmaNK2ogHeJhdFCrG/H769+ari3uTiB2Ssk4Nzv9H+84dd0svx7MdH85Yqu8C1G
 MDXj2PWZ12XC9Tukupc/Rsi+F555ZFQO/brGs+Tth9XtELHF+ljEIhOG6cq9qx9S
 ZcZdHqLLwfLLvLqbZZhXuNfjLusTgqKVzxcuTliqnwifwG8GhfnlQ5Lxwp+vqzJr
 kwWjOPV2C3Fq6Nn71t294h4V1yAANJ5xIE71MNrrRxhhO/ZgpJcCLbqodyQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t0fmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:23:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8375e2df478so251171b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778134997; x=1778739797;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9uWI5/lasx6W7TVmUmXkz+IrOXTCg+uMGmg+AQA+9o=;
 b=JhXqEDTmxN3T0rKQ60zaaQDPjD1fk+FR3MMdd5WBb8v4pQkQ8LaruJcvqzPjGhQiUN
 6NGu8G8xeGwihymMNkaskhORRpY24Q5jhBnmg68b6sl5LKrcWkiN9NdDqgeQMOxIUmbb
 uHPAtLMGaGlbqMDuEX5GU1vN09rNTGIxRH+zI+e6HfvEs781+6RpDnJyJ68+tywiq9mQ
 NsaTgy17C7bIoBGe9MNNlpwtn2oe5zIZpjanupeE2oPUpVQwB9AJ132UDVu9FaeQq8cG
 LELkUE5UUA6HNyYxThZLmcDxqxKVlkECOUkBEaBYLFiEoxLxS9r9/cikM5BlJcXb/z+G
 ukzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134997; x=1778739797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9uWI5/lasx6W7TVmUmXkz+IrOXTCg+uMGmg+AQA+9o=;
 b=iOUesamy4E04gHY41XwFBifFKxNwPJCnjX4J8dTIfkYPJ3KmrrZQxNz2YuiIOi67rv
 SW9himk2b9gucmsx+RvXOyANwMaQJZoOaYCEZyx9+0cJri9WrnB8r8HXV83g4RshPh6m
 f4eIrmCeyNlC3+X9Avefl97eHviRQIHZ3cXWGr5kBVDNCEp32kegMH/ZvyWS1PhmPCVE
 lI3Ss1JlMMI5ibUV4nH6PFJQPxPqizl3bWCr5uLeN2/qcKRqRUNGffRn1bkf8uzfVFTU
 YBGw46QhUP7QHqNs/TS6YIO+oM1eocMH82iRjurRbUh63ntmCbWZy4bPf1Pjrh5MkegO
 p8Dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FsHdbQtJPmqTwcNZuM86DGegZuObGJygueSomVJ3XCKnr5SJJ0csHwB/+/P3FCu/rCKW5Sfs5SSw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylpSNIMChe/wvs12jKySasBwHsBeuDvN6y4Lzv5DDc4CZvJWao
 CPW4pg8a7KqkdZLli0mQAWu9KdlyikhkNm1ik3LkCpI9qmOICWp8tc5sXEU68f3vRT1GFE77cX6
 oxpIeEMacXQJjS2K7hwt0QUnrV8q4IXYmS7+ccs+t0u3Y2j6BYqef5YIqTuXNTn8akTwVug4=
X-Gm-Gg: AeBDies/6b/J5CLf/Ci62nXM1PRgnBXl9JYNiYyN2jRFC7y3QHjvj6fd2HgroNinxdL
 Gk+ZmY3HaPnjysQ9wdJfvapZ547EVm255qfM3m6N40yGMuq4jFld4zSBJt6Hyx2ws54P8C7dq0n
 6vN4V6NWW2181NgqQ8mThb+H+DPfPaexYOnENmxb+DjwxuxT6SLHMgMyPv+mZFDQmEdZCktqeXZ
 68OHV/AmlAoejoKF53CCZbrVQgVhWvA+bZ1M+sZ4g1xnhocBF1k+8sWHTXx729IwQNUuBP7Gkdw
 vkRw1qNibCTOGP+7jb/BtVK1b99mavTmzNox7TvHbXG77grK29qtHJBnCTtx/Gm8efh0JGd8I1z
 eRMIqeiM027ikoXa2NHa4UiyOraGJSwlUpibS74QTY+jvJd9OJTg+YF8AyyorY5GCElIBJwfOkd
 8/vt3fXoBlTpWUnEjpng/CUGXO/Qc5OUTtlArCXhrILiEWV+w=
X-Received: by 2002:a05:6a00:39a5:b0:82c:2205:507d with SMTP id
 d2e1a72fcca58-83a5dd5bc34mr6085690b3a.36.1778134997534; 
 Wed, 06 May 2026 23:23:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:39a5:b0:82c:2205:507d with SMTP id
 d2e1a72fcca58-83a5dd5bc34mr6085657b3a.36.1778134997009; 
 Wed, 06 May 2026 23:23:17 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:23:16 -0700 (PDT)
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
Subject: [RFC V6 4/8] PM / devfreq: Add new track_remote flag for governors
Date: Thu,  7 May 2026 11:52:33 +0530
Message-Id: <20260507062237.78051-5-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc2fd7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=LlpFjwiIyvKxJCA_QE0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: SHtrWSAI2A4zm3bM2M83OY6b_QJ3Mjqn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfXyrlDiBMeYnT8
 Wq7wRuHBdOl1OW7Uye55vPXE/YhMOSauhH/Of4VwxxiWJbCNRsj0L57Ecq9/NXPQddildk5o7oS
 3sNimTmUuvOVUCTic1r+nVBVSte1cigLMLNhBga+HLdGSAj4mJHwx0xEmyzMhhUNT9O/zd9qoG+
 vzNwxrZjUCh7ZTzN8+1iDTFDk0EOb5tCpNjQTGs9GyWstOjzr2Lyt3DM7BOMPyowUx8z4Ba4CAW
 JD+4FE2CNyALZ+0BD2NodkxDMXqL9aNGqfGS5OL9qddQkQ7IsRDa8OBT/7XtfOenOWsK/ybqSb7
 CtlzdFJPN1+IFRT6qqZ8ziR5jqgSma3p5dIKlxxGesaeCEBoJPs2xHJpAnvWzW01lAZTkVpoeQm
 srLd1Isnv7bmwjTf5BMh1AzICvea8KrzvNfnktEacNy5iY0khSCSn3j9LkqokjZ5HdrzmCAC5+T
 xKhZFNm+ZLou3NSlHAA==
X-Proofpoint-GUID: SHtrWSAI2A4zm3bM2M83OY6b_QJ3Mjqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070060
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

Add a new track_remote flag for devfreq governors as a pre-curor to
adding the devfreq governors that is responsible for tracking
frequency changes on remote devices.

This new governor flag provides for a way track the remote device's
frequency and keep the trans_stat data updated and skip the frequency
update sequency for the device.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 drivers/devfreq/devfreq.c        | 5 +++++
 include/linux/devfreq-governor.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 85e937e321e8..e0272078912b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -348,6 +348,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	unsigned long cur_freq;
 	int err = 0;
 
+	/* Frequency already updated, update trans-stat info */
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, TRACK_REMOTE))
+		goto update_status;
+
 	if (devfreq->profile->get_cur_freq)
 		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
 	else
@@ -375,6 +379,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
+update_status:
 	if (devfreq_update_status(devfreq, new_freq))
 		dev_warn(&devfreq->dev,
 			 "Couldn't update frequency transition information.\n");
diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
index 2853f571dfdf..83aa82c4a9b6 100644
--- a/include/linux/devfreq-governor.h
+++ b/include/linux/devfreq-governor.h
@@ -36,6 +36,7 @@
  */
 #define DEVFREQ_GOV_FLAG_IMMUTABLE			BIT(0)
 #define DEVFREQ_GOV_FLAG_IRQ_DRIVEN			BIT(1)
+#define DEVFREQ_GOV_FLAG_TRACK_REMOTE			BIT(2)
 
 /*
  * Definition of governor attribute flags except for common sysfs attributes
-- 
2.34.1

