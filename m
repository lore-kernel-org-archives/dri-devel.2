Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DE3CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F4010E012;
	Thu,  1 Oct 2026 11:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NpzTndIV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+kvjd/J";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7493C10E012
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:02:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xfvZ1511890
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 11:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DkDbVRw9K0aMKne+WgAK+QVXIJQUCz5NzjDL4TgnTpo=; b=NpzTndIVx/e7yEO9
 DeCI7pfme7aKB/HMXORZ4AinIdJTVzu2XwSanrEdD19TzFL+1JFZHAUy0MQ7R3b3
 mUV8uU+thpH6Ffnq0+jJGSBuUksTPjnw62Vg2folDZbGKUdtcs0q2dLCqX5UALV6
 3ZWduSqf/9vQz23ZktCg75XH2JlNjPl+IG4WnZW9JHPg162yh139Omem7zxQpVOU
 AwesmdvzwF/cQ4iYQeQ/E5OEjNiCAhq/IvOfw/+vgcmRUViYAZUEyfwO4hhInLst
 xFxUUDnp57IC9NMbbWBNUWDAuctsVSjCuOSKzz4LqNpHR6ghIGkDtits6b1TH8IT
 OJRamw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h188sucb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 11:02:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1b80835d5so3861198a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790852533; x=1791457333;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DkDbVRw9K0aMKne+WgAK+QVXIJQUCz5NzjDL4TgnTpo=;
 b=M+kvjd/JG+b5Jc+mhG6z2/BRHijFSNaN5hKC5gELFvVbjQ+83qllUYDKFh6Z1vA7bp
 pn5zrXOueB73EkxK09CfRMrUugwM6K5rQD+Y0oIv//xqabmwEQa63ItJUDUALJT+r0uc
 68tDZwXOYpWj9YGqvsy8t7d3R1yVjpA/fvHM5jj6tZ9tUPYAkP9rdttPiukEXPTZzBJC
 0KAuhwRL+RkAdAOauzZhVYoDntQIvHlNw67ujE4ksloYxMEiejLTIf+JNU3T7BNuWfxU
 7T116UG47PdCr6wLmvJjsL4xBBOeBUmqvGqY0Yj4C4bVfy0MGboKUNVNSogdVJ8MCkpJ
 R+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790852533; x=1791457333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DkDbVRw9K0aMKne+WgAK+QVXIJQUCz5NzjDL4TgnTpo=;
 b=OB6pOB2tpEQnFl44nWrVlsdMu7uLsalwMTGgEn+aXVwjPXJkwHo9hfIIlBsRnSRGHe
 O8Vkv4xvmHONNfxUWfLAGT1QUrMBlELpH3NwB7KbxaA1I5PnSn5c7YBgnM+GHoD4TZRm
 xfhoHGbyAbqnkiGE5jvK8MWsQGw9ehoe6Kr2ClTpPZ7I4VcLWvSfODGVuIvNyEkWU8go
 ewvuyucaF3IKSZoJobZlFQIS1DH1UQlGB1N3gXjxUasXRwn/vrwG5ekWhkS/orKQ0f1d
 6ESaU8jLqgOe3lBbKhrX5j6hxiRc02+LwU3usOOQXwQ5GRGqTDVJdZe/74KelQblMPEP
 5Vvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBypiCjosWiyeII8DjOI+juT5qHNf5n7M0mf/roDIhgvTh6l52wbCQuxHJrzCU4fel4plpBn9MQR+N8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kVUF4lA+Q9DccgYbDj+tGsnUq5mDZA54bCV9vXU/8AGizx2IgL
 H3N6P03KhGTnclBGv1pbWt+bpZwfGW3UHw0nfwGVg49oM4iL96jUGyrKtsbE/58ksGYt5TQn96C
 zLituGsMitv0x7HDGJ7sZPlDKxLq0v2q4dyeGW/In7nLEV5dq8cI68XSJpKMIITxinxdjMrA=
X-Gm-Gg: AYBFou1OYghqpwwodIJfbGqRWdqCWxWTqsFuRw8KC8W+HqEoDta3NQKXccsaKOYaleQ
 c3j+eRHiGJl+YNk5WwH2jVU83JqkYVrN7fAsNuEdSlpzfgkpL9qEvKJFYl8sFq1jB6ZH5gJ4NaE
 OAq/qS3GY0zTlRqFncGcTY6mC02C1aNrjkhJHQlpUCToTSDr0t+lo0sDDxE/taG4dqe5Z3zkQQx
 nI2whJAcBTXgLChCyvlkS32PYTT051MPwudAwYtZPFdbqgNQFXa3Fv6CMxD/F8ezKP22ktqYWLW
 zmnlqXO0naSNVgIJOjRvKxT2EpLHUWsVjGeoo5sXuSwhOColyxvnhnbc3gONvBE6vrhkiMoKLYn
 MW8/Vw2lJzjXo1wIBJ5GV1V7HSHoXFOtYrg==
X-Received: by 2002:a05:6a00:218e:b0:882:99c8:8678 with SMTP id
 d2e1a72fcca58-8874a79f1eemr3714171b3a.16.1790852533099; 
 Thu, 01 Oct 2026 04:02:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:218e:b0:882:99c8:8678 with SMTP id
 d2e1a72fcca58-8874a79f1eemr3714120b3a.16.1790852532506; 
 Thu, 01 Oct 2026 04:02:12 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-888197ced69sm886049b3a.48.2026.10.01.04.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 04:02:11 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 16:31:25 +0530
Subject: [PATCH 1/2] misc: fastrpc: fix NULL rpdev dereference when session
 alloc fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-fastrpc-probe-fixes-v1-1-1376d93b8b3e@oss.qualcomm.com>
References: <20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com>
In-Reply-To: <20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852523; l=2369;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=03XIH2O6sdDp8jBNtcMZmDL3Sp8Yt02H690f7pWeLgQ=;
 b=PUC+a/kjGMciW26JOjwX7e+QyLjNCCIp5KkBOyrnvDjoTZ+eDBlQlWoDkBxjFltJr5gjub0VJ
 97iRYxSD9RdAS87H1Rl5ojgtXjFYeVut9GpUvMim4uA1KTJH+61UBUJ
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX2CiajIFqycO0
 G+cd0UynrVb+SXKWy1DapfAaV/mjctn1arIs103/5DaeBoc7kjIvszzPF+MvMbpXwGGgNiN1Yvz
 oPR//nkiIOmqQewbRdz/14Dk/6whsK0=
X-Authority-Analysis: v=2.4 cv=OozaWC/t c=1 sm=1 tr=0 ts=6abe3db6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=HPkHAgnwbDoOiCnvmVMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: xUBWtIJdPI8UGmzq8_5QrAMHETaEoFdV
X-Proofpoint-GUID: xUBWtIJdPI8UGmzq8_5QrAMHETaEoFdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX8nziBvbZ/lK7
 pysH4H4BlXpjOFMZWCIXwEzip2+Kei6gTGwxsO8WczBDddScsSrTrn2l5e+HKRjrGJYe7Uku9Uc
 ecUzfi4avHKZQWtpuUpp8SbgLBSCUDHKb0QmCdfprJCeC04MGj5x45e9rlxkC8/BzwsheXlZQ+Q
 StpQlUdEhm15+9c3hzONwF3L0FQQl38wCiUTA4lD6TGcl6sNl/dcuOb3Lv6KN5jEE6lMrZp5jOl
 5VIAf/32DY/9lPP+GGG709qVG6cjg5wgUISOLZwWHaFxx65Ny5xKEjfxKMmhTfMNX0IfQn1GjSm
 uWlRMdi6a0BgwxpXPc7CVNNLsAA8tsbkphGKDxpvZjAeyd6AmCSHAHE6D+3K4ytrURcUTg/qREj
 GsLTgnoZj4coOEDp8kUcg2rV0q2fNP6QEExSYPaXiTqh97HiWEaaRbr9yaUeQ5SD7v1EBh6hcfJ
 Ki+zjkrDs0/SO19mL0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010043
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

When a fastrpc client process dies abnormally without closing its file
descriptor, fastrpc_device_release() is never called and the compute-cb
session slot is never freed. The abnormal client death on the DSP side
triggers a glink channel teardown which propagates up through the rpmsg
bus and calls fastrpc_rpmsg_remove().

fastrpc_rpmsg_remove() nulls cctx->rpdev before calling
misc_deregister(). If a concurrent open() enters fastrpc_device_open()
in this window and fastrpc_session_alloc() returns NULL (sessions
exhausted by the leaked slot), the error path dereferences
cctx->rpdev->dev causing a NULL pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : fastrpc_device_open+0x1b8/0x258 [fastrpc]
  Call trace:
   fastrpc_device_open+0x1b8/0x258 [fastrpc] (P)
   misc_open+0xd8/0x1a0

Fix by moving misc_deregister() before rpdev = NULL. misc_open() and
misc_deregister() both take misc_mtx, so misc_deregister() will either
block until fastrpc_device_open() completes or prevent new opens from
entering it entirely.

Fixes: 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is available")
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index b29c1fd00de2..7ab1cbbf19bb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2706,6 +2706,12 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
@@ -2713,12 +2719,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (cctx->fdevice)
-		misc_deregister(&cctx->fdevice->miscdev);
-
-	if (cctx->secure_fdevice)
-		misc_deregister(&cctx->secure_fdevice->miscdev);
-
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 

-- 
2.34.1

