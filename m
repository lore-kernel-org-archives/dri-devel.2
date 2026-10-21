Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0F606A323
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kQoBWcJ3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CjgkwJC0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC391121FD;
	Wed, 21 Oct 2026 20:53:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C851121FF
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:54 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeEnY642097
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ocDu9x7a94S
 WPcpzxK16LgiMD4smeVd0t/ViadjFsRc=; b=kQoBWcJ3ixHquOP36eUDlperjY2
 XVKR9jk/zqcD5LNmbGH9YgDhxdkkLEFfgzIlB54mYQfnmYo8UlHcHppMkBf+uFSA
 sSIdhanY++X5/WELlbKwU5jdbWAj6KzO2aolQkfCBtWO3my+c5HmX1jH0e8AZgkp
 hiR+GCPBlLYqE2oa86r7hVQZK19jiHbxldLieub9dmRSY64YRD3cY/QKbLe32WzH
 +iLGxiSgDSttwumnvbQHLBzl7dhyOBzd7lkNHxZfREWjHGFR2caVDTJd88x6UTZT
 IBHLXJCL1tN7w5afMj1XXYbW9EfTbRicXXeaMA6MSrj/8UHGyNFu3zC6jSg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q9tvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so1423408a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615972; x=1793220772;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ocDu9x7a94SWPcpzxK16LgiMD4smeVd0t/ViadjFsRc=;
 b=CjgkwJC0fFrkumxKWGW70A0UvfK9uHk73gESeJWEETXDPMHeg/OgIGNJJ7s2dUKkqo
 Gx/lGVvOldcIaty0Qmb7cdhyJJ0c889y0ELqHn1oVpQA88QJoJjchmunPhQTOB0v0MDM
 Lt5bfjsAhEUm2yNkMqi/PAhxDZV5rBi8NMH3WjRHJHD7udJWarGKsQAsBdZobloK6SQO
 ZkP7XvefCRXKPFU86VozUNmq7AH8GUX6hn1569oOGBtRWAKRNZVkf6k6nduBbnn9nWb7
 Hyiom99FnTFrF00XYpJIpHg83btbfL0X3COFiEuFhfkXW3Y/2KV+9hJKrixfjos1pPxA
 nehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615972; x=1793220772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ocDu9x7a94SWPcpzxK16LgiMD4smeVd0t/ViadjFsRc=;
 b=Ky8udH9INjCPK31pKdbRCofQe5oCV/xSszRe67xTPr6y+77ZYIv2D/9D3p/z+xqId7
 2MzPasZCEFGUf0cB4yAhg5TUG5LqjKh8tf0Ja/Z1IEB7Ls50taoRl55rTZddY88G4+sE
 oQfB9OIETwAnZ6fP7D0yaMs3dOwbqrQtt1pSPEsWoEodCu+fkQobbLzCvGxwBRz18pdz
 2+1nTTJeFnUcvaTnuhBIIScVYRfW8Johb91bdn8JRtRPgv2stBAqbo9FJvBm+tBsq7qq
 QiXe+TCkwT4WQmLd2i3H89bFhj/EJslwFqqdQf99TrM1P5Z2d/T6XSopljgch3idbwQK
 mxvQ==
X-Gm-Message-State: AFq9FYIsx0XsmOEzLl+cW3rwFlsNzSLUCa/CjYFBQtDqDXt5wTgl/Wjw
 ui8cZQLvlLLhcmHXugKUoCrvvDkEMHURe0In4EDPbQ/DYDIAlnCr9Hr696djj+MVFV0unkvGphT
 SnpS07OrVkoOQpFeCR9SQOj/nb8vriY67aneJFRmwg7iTnTeMm/899ptrMIL1KKx/pOb4Gy5fil
 05pHY=
X-Gm-Gg: AYBFou06blj7cmzQ3zLF/EtaHmEcqQslX2ZR1gZdnMHo85Yzwe3wDwbhDtu25Ns1TBn
 7bCsmfFwBaCW2S+iu5Wm26K45GaxTiJ97dmkHkbrShYBxGIx2A06TevKg/GwfTGK66Zi48RowJm
 Bs4FHwq1T4sG3+Oyi8YX4BzKNIomedXYfLLTkvE5bNN2NeV1I+YDfOhKjJm/zC8VhLF1HK+6gSR
 VvgG6PPiaaWOAZ4+EPL7TfIaF8hy3hcDZrISYkCyazf5GfcSXJV4ZH2HP34jGvGOSD+XMpFTkxE
 QqoCnCkOUD5pK7wrg+mIvQ9C/2O/Pgv0TnCT8EyPlGr+9jYPXUsXjbLsuSIgynpMN4xbG1/OJvy
 5giub+FrqUe7Z0/J/r663VF2IZf98wc7nRHYBL3KbbjGVPfRdCw==
X-Received: by 2002:a17:90b:1d45:b0:3ac:7556:8ee0 with SMTP id
 98e67ed59e1d1-3ad86ee318amr2589084a91.19.1792615972608; 
 Wed, 21 Oct 2026 13:52:52 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:3ac:7556:8ee0 with SMTP id
 98e67ed59e1d1-3ad86ee318amr2589052a91.19.1792615972140; 
 Wed, 21 Oct 2026 13:52:52 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48cc51dsm937500a91.17.2026.10.21.13.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:51 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/14] drm/msm/adreno: add temporary __maybe_unused
Date: Wed, 21 Oct 2026 13:41:34 -0700
Message-ID: <20261021204244.67160-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX8y71R/GS8ggz
 2rpOcI3QEVCWBB0r8LubtR1zAqu0bpLHBDAN/gknD6NaCJeClVw8zcDQ2GYXqLKgyzVF3KDWjJk
 eoNpPUfcVBhlBHS3vxAwzbbQsCxXFwk=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad92625 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: BdEi0DLBCsxkftevAqW1DBPejpQk5iPg
X-Proofpoint-ORIG-GUID: BdEi0DLBCsxkftevAqW1DBPejpQk5iPg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX4qbXQKzVmZBc
 y93JV63TXSf89vM0jsBTRRO3tik03MlCbCxvP/XV6E2pAufF612n4lOh4TNxvNYW/2n46Aj9UDf
 vDTCCkeywxdQ93NbDrCNqnHh7ycWy6suOCwKkMpxW5vnocFwM5U1gewHbEvabSeDDZ0WmEMcUqY
 u7lx6jadMrqymRaOKkic6nFiDoJQCZ3GK2zv0/OgUusH4F+xIF+WywRqlM3+/1D8VDfNUSr/Sfy
 MiQwTu8krmfOynS51Mlq2gNrVHLoTjg5ACVZstItq/cwNKsLp4btEAvI/+imWqblwtwSorrtJhZ
 05RqRjulk09NaZ1z54jGiYfNUmnk8RSljFhBFjWOgYQN6kofSjRG78nsg9UcYiaA1nckfdUmxMQ
 nxMEeTcGQVbPsX1Y5GKPKE2HZeCr+yPylksrKm15IsJ312JHWEwZYkdkqGXnqu8GF3q+ytn/FtJ
 ot9jbVyLkwN/1TtpY+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210083
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To keep this series bisectable.  This will be removed once there maybe-
unused protect tables are gone.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 6d6e4c7cf919..c43efb85fde7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -168,7 +168,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name = {		\
+static const struct adreno_protect name __maybe_unused = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

