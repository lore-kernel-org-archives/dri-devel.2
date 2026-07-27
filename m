Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA0AC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CC410E483;
	Mon, 27 Jul 2026 17:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhbbGycb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YMWdwxko";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E5C10E483
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlgiK033208
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Xrd7+mMUbjl+qLUo2m9xXeSQiJ457xxEDq2
 gJokXZ3M=; b=VhbbGycbI5Om9lPripyfCVxjpPAUivKodLYbtstHuWZ59Du22g2
 qHM84SZN6ksncb+BXmfx4doEBT8oDLpZba0dICNGHSxIC4yxvdOFs0lDGy+yDfPA
 Q1VV0JMOCluAISVAVCIoxZLrMhAQ0N+KL0AS6hwap/ispOFrQgnxynUXPVN9SWrw
 v12EStWcCsT2z7hzh6c8XJnmhSvr9KQAA/rlnQcLpgv3M85IbtpeQSd8UWFAcUqj
 jHvP81p8q3IIlM1nfjsAtILQZPabAw2d6a1PHDU4qL9siyppw8WUugiPw4brbGgI
 o2Ua456AWTH+trt3XPs5n4AzwAvbo/ujvAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c6267d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283fa0656dso1725681cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785173610; x=1785778410;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xrd7+mMUbjl+qLUo2m9xXeSQiJ457xxEDq2gJokXZ3M=;
 b=YMWdwxkoBesRLEdrMnrGTd/Mh6ZZbQMUMtqWoWTSUM5Mh4YDjm3aUZhxwJsXGCZPqq
 hhWHU87dYyEXjOJEJ9qo7GwbYEK+K7vST+yWRw4Tq8NFq+Fm0So7OKyQU8c+O1MA4UZ8
 8WRS+LNYLw4bEkIXHjlqk/tr63DIWc+GtWGRQVvrrwZ4wXtOZrbDlsjLDY6Oc/55hM9T
 JOnsw/0UoQqZfZdZwVOmozkkwWc2AEzUNkUZyFo7cYbmQoPInCEBIgJsnJAW0OA9Q1Uf
 24a754n4TeV0aVlZAcVgRpwnvRKvRqnsJqmH7Gae448juq6tQl2BjlLQlDnu9S59Tqh+
 uW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173610; x=1785778410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xrd7+mMUbjl+qLUo2m9xXeSQiJ457xxEDq2gJokXZ3M=;
 b=T42wSvmNeuG/L5tenFrnGnPplQ7qzZw5yIJWzke5WvCQF9f+K5XWqIoolDaTlGFD7x
 hfcYUt2+TJAn1jVlBFqpJWFIjbcadD4zzVwMrkEpPZw6eZj3V1ZLNJo9JCfD2cFU9DCK
 oTeZMjevzpN85Q3c2O3j4mAjQitT2NlVEETgSvHMncNqif7hiodOzNhmeE7XBQ3Xvgu/
 B0IgrXlINLu4GWEkOUMCLMqlO9MDtMvl4yyk1hCbKNZkDFoGERwr+OlhM1GstcogCRKt
 yRa7R/K+2JtYcPolUoxHbqEsCsEZLy5TLb/j+PCRvz3gupr7os8LIqgY1cGP1EjqUW8h
 Ok2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGiINETlMqe97zVfH3zNqS+fFdU5GcuFDPu5VW0x23tf6SlM69oU6b4kn1awqPhTkRBevEEFljUgA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWn49L6dZ76fVXJ4txmOj1b/l0vWsYEaVTAZ/GIybeDV/xon+B
 1lNA+w8CzYeW7MyF0DIhaphXK8wk9C43GBePOZZGo1T7CPIjEUZdmRM56cqOWPtkaRe7Aj5aiZp
 q++5q3BtfsJn1qCfuXd/pJmFWk5+dN5PQu6BV7Aelup4sHxViY7sWEYFRCv8HNSkVILeGTFA=
X-Gm-Gg: AR+sD12O0nISC4k3xouqAvoMAj+Es3s6Svvo/cRFNj87z7tn0URoME4oVJWlCHh92pC
 50/mwc1ik7sPVklzzaQv7wcBV5UlpVhkte3uQVz0BbB/8+oKWJwQQQojN2GH5aMfGs/435yl7pr
 oBr7BC7YTs/XnIdEzcMWgPsrTGjzxIcCTGxWsb64ZPhINdLGlPFkUdAJBlYgYcAh/AbHvb7z3y1
 fHhDGeRSa1O7AuS5xMTeCojz9JXE2JCTKuwLPEVE/j83wUdqVBglgRCId/lruZZGcu/axhG1ZUv
 3mA9Hb0kgqvQhfamWvnhnBy8OHs43fGMmTJrYTclZvKUpYy+N7EFnWqCOFSkw08BCvGxb0Hlr7a
 2FFsIO0daNV1y+lfGPPsGmIIQfADxxfPe4OLtRHdp
X-Received: by 2002:ac8:588d:0:b0:51c:7aa7:e0f0 with SMTP id
 d75a77b69052e-529d1fd79b1mr3817801cf.43.1785173610030; 
 Mon, 27 Jul 2026 10:33:30 -0700 (PDT)
X-Received: by 2002:ac8:588d:0:b0:51c:7aa7:e0f0 with SMTP id
 d75a77b69052e-529d1fd79b1mr3817511cf.43.1785173609636; 
 Mon, 27 Jul 2026 10:33:29 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5543370sm2945391a12.15.2026.07.27.10.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:33:28 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 0/5] accel/qaic: Add missing <linux/device-id/mhi.h> to .c
 files
Date: Mon, 27 Jul 2026 19:33:21 +0200
Message-ID: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a67966b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=XT_LLXgTnYouiiFBU3wA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX3fpDzImPUDnN
 IrZKlilkf5Sj2dzHirMbRFd7b8bHCH2M0XDTRc10Cz4PDbbFzIo8Utjknx2pbAgmgzMsPxkjpAL
 OB43QjSxGu9IAN5aUK3o0Z5KFN7Bqls=
X-Proofpoint-ORIG-GUID: zjA-hQa0R3jaojE-3vVKsvC3MtZTwKN8
X-Proofpoint-GUID: zjA-hQa0R3jaojE-3vVKsvC3MtZTwKN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX7SrrHNJM5hnB
 wmKQb0ukjB/SROkt4DedG6l5Ra13x5qCwFkiLr7450Pt4RdybWN9m+Xt7Iz76LcUwdyls5ojyJi
 WoyWRFWu3s7KO5uhInyE/pJzjuNe3MNqDc3uLZLlpR2dpiTeitQaTANEGyQyyRAhGXBMhf6QYh7
 fOuP9uTNnMDRqAg/EDLl8fCx64bvKxE2MAQPLlBkrObJF8tLUgXkvW44/2ldk+ScrWHJtwhr4vF
 jX6XtI8PsKIAVy+jygDPCUjwB+SRycXlKWtydt2brZKSIfB438tS7nUPl61SoXlBI4PLbGUajIr
 rB/L8nIMZjBO1Lwd2nqe/gKuT2kZcM0fSy58AxpR2HWoJRU0GQSWdWE/EKuSdZA8d8PEozeVb86
 eI/Q5r/FF+oC4sGGwz1XO5BWKASDHSSJyTF7Xkk2Li6FG4G41U0sZnrdoSpRnyXiBE1Ov3c3ykr
 tZOBePNx7EuzLF4WPjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270162
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

Although the qaic driver is using MHI, it is missing the inclusion of
<linux/mod_devicetable.h>, or the more recent <linux/device-id/mhi.h>,
in some of its .c files.

This series adds the missing includes to the relevant .c files.

Youssef Samir (5):
  accel/qaic: Add missing <linux/device-id/mhi.h> to sahara and timesync
  accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
  accel/qaic: Add <linux/device-id/mhi.h> to qaic_debugfs.c
  accel/qaic: Add <linux/device-id/mhi.h> to qaic_ras.c
  accel/qaic: Add <linux/device-id/mhi.h> to qaic_ssr.c

 drivers/accel/qaic/qaic_debugfs.c  | 1 +
 drivers/accel/qaic/qaic_drv.c      | 1 +
 drivers/accel/qaic/qaic_ras.c      | 1 +
 drivers/accel/qaic/qaic_ssr.c      | 1 +
 drivers/accel/qaic/qaic_timesync.c | 1 +
 drivers/accel/qaic/sahara.c        | 1 +
 6 files changed, 6 insertions(+)

-- 
2.43.0

