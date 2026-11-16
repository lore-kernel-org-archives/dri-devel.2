Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE9606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=krIi/Ql8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JJCSNDRp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7F310F16E;
	Mon, 16 Nov 2026 13:27:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1060610F16E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:47 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0xAj4069496
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GP+lNZ04x6U/6g+BRd/Rsoxc8+T29rvyx0Ll9LTUk3U=; b=krIi/Ql8sMszVbX7
 fCG6Fpa+7p+PDJ9pS6lR2Q1ua+4J70nniWw/DgYTyblXIMJfMqUfnLfT/O3Gofcf
 bXveXpfIA9BVwWz33uS+McfT77rYFGDNu8p8wwHBBPlQr5r5DAZ+CGnk/btSbqba
 uGEGmXa3fTo/E+5c8U6Nyz+l53jFVLFLoyoeQJNjkAkSMql+0cPhAjwfgcfB+ttT
 K2xNk9M4HnoZpibl37iKrPt1De1dLOreEiCDBLcwE8IxCg4L5qZ6A6xFzJbcvzgc
 h6We6rBKqoJYW0g0xZAXx1v3l0tW7cPtFM4H8ZcDkV3uENiyoZaHBZGnkOhMKpt5
 BEaOKg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmceju4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:46 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-85f37d25fa3so4064209a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835666; x=1795440466;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GP+lNZ04x6U/6g+BRd/Rsoxc8+T29rvyx0Ll9LTUk3U=;
 b=JJCSNDRpFEviGKi9qSBuxFprovkX5EAyOaDzZD/3aQ4oPBwHvph55D0606PXXgSp7N
 EkKGqT6e0JYFfjXs9ylDYl4vicFc8/U1XC7g/8LIRoIS7lv5UHnzeIq1jJRLmDcuG9mn
 JPxYUTF0eKv0/99eprTa/FtwLkNmOnx0Eaa/9QjPrjptFWz3v1kTKfQA3tKb9FSFPCfz
 wK58lOP95TkD8TrQOcOwBDLBipSuU+K6IcdSb8PUjBCBsCPEpeSkInPfLo4C3UBE8//M
 AJFSAXyJpU73fbBGFQhKampZReiJrLsloOyhqFdja+0WHSOGPx/7r8tjcB80DNwt4g+p
 dBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835666; x=1795440466;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GP+lNZ04x6U/6g+BRd/Rsoxc8+T29rvyx0Ll9LTUk3U=;
 b=IYu0rl8Jbgt4Avjv+AOudB1Dnw3rEOAalSqMTLFzKYkyNAKQdOyeaB2X7JNejEqZto
 VYWkgZm16/em+nAMof+fq9+mi2lJMVYNFFVrjNBSCOrPcdlrwY3C0mJukts6XJpviMho
 NI8SsfwSgHYqjpQp3Eq7vsodfZjEBPVzrdZ2NaeycwjS5nmrOD0zOVyWfjfL/6rYCZUx
 GDZ8yKVb3N4woegLDAgF2nvpvq9rks960gpOQrgAUrbJvPDNA3hW42+IFbO/3JTAZ/HM
 p8QKzEWOYirUreNe0Fp+Yk4Itj1yOSFUqLQqveSPuFdlvGD4OuWCVRV8+b8pNK5j3BO/
 ar3g==
X-Forwarded-Encrypted: i=1;
 AL+hErHULlVimU3/S7OU1ytJL5+obBARBWD8dmlBIR4ExNeAxQq95fbdVKU2mYYE6nmklbx4jlCZLbyLGXE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PobHVQ6CasBLPnvVa7lyt8H7Q+1eLewh+bWoosVLWsUyaPIqd
 kU6Za5zgsB8Jez9/wb7aLM69a4Bw2t28tZnjcHwgNuX5YeSP+1PtWSgZunzjCSC2tclnTHxy4bJ
 k2sUZFtba6/tdEgbaOhElUQCvS8K3WudMqqMNc28dZoytVK2MrFTaRHM3SwAj2Vym12YsUE0=
X-Gm-Gg: AYBFou2x+j9pQ0AdD77wVrFnxL7MI3h9gA8Wyn1Hg2iAkAkdrgy1zTcb/fvlyOjsy7Y
 S2CsR72F9OdegdHKzVF1GH6MfA/4Ab28lxS9JbnPupTTgtJKbnb7lWYLf2n8OvIIkwm9tGevmmE
 8e6YBdpQz9R0gk516iD6q3dMk4J5l2tUFKKDN231+Mjt+nFbm/mUEOuL2E8RYH1yXfEaNagw4Hg
 H7Ud+9X/eekGKBBPd4ul1a6EYXsU6c/ADV3BdZrvB7HGrS/O1yFUFZMKJW73TBX+XDgUaELDie9
 tjO6goNVHktTX2f/xguJyK9ahXZB1SDikuhqgKldCQcgDTjrfQVgjS32/R4e1dmj0Ol4fysDa3U
 +QIBha7xPdY55sGfKj0QAN+hxcogXuZLMXo65T6ZHzrQTKW5BuVMHXZ+isbEzXTGgcDgyKLvfeJ
 jWLtb3eMU=
X-Received: by 2002:a05:6830:4122:b0:862:ca2e:918a with SMTP id
 46e09a7af769-862ca2e9f54mr2358114a34.19.1794835665609; 
 Mon, 16 Nov 2026 05:27:45 -0800 (PST)
X-Received: by 2002:a05:6830:4122:b0:862:ca2e:918a with SMTP id
 46e09a7af769-862ca2e9f54mr2358089a34.19.1794835665172; 
 Mon, 16 Nov 2026 05:27:45 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8628813346esm10012527a34.17.2026.11.16.05.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:27:44 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:57:30 +0530
Subject: [PATCH v3 1/2] misc: fastrpc: fix NULL rpdev dereference when
 session alloc fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-fastrpc-probe-fixes-v3-1-3cd56d9d9a93@oss.qualcomm.com>
References: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
In-Reply-To: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 stable@vger.kernel.org, Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835655; l=2528;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=qyOzQilXYkBjF32YjLtPldFWtQAux35R3zlEUXH0auc=;
 b=7J0qerE1hXz8b3V5kFX1tH1Jt/6ibT2/D4UYtCOjUErGCE32WTbul+JYEwMX0JUyV4JyKlOFX
 M2h3cgjAW8lAm3VZGgRjSu8RhE7pj15Nn06HKnmejmpcV40KriI56Fr
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX6vVBmAgMPMCh
 ObZx/CI7SIvMg99NTG5ysJ6CmUa2FC9xDHTqzOFzGE05N3m3vZgBdi9TweTS0xOD0yHMu9x1jt1
 dYeECbWXc/+kMu6Idn/j/uWGXFooyuY=
X-Proofpoint-ORIG-GUID: I-jPjIvqlBUyVFVbCFvi0Yd1yTkWxhsJ
X-Proofpoint-GUID: I-jPjIvqlBUyVFVbCFvi0Yd1yTkWxhsJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX/sPRVVfxXk/f
 3+AWJqef5r12LsrLKADqB8JHoG6yg+US4p/VmisQLV61RHRblmqrbz+g8/txBjxhnpadjVC3/LJ
 Hy/wtNeacBMqoUyWtediPVii8rIJWYuJlWppZgHRiSkjzOuaNf3HIjKBFf0Kw7u6uZNg2AjS3yY
 7AbUloxa/n7gx9xIV2BuxFKTS84wEtdK11XGZC/cXagSNypRmuQDNLKV8xcicOAPtyn+Cu8czGx
 pxmROC63kAlJAh2PGtH274DSIjvJGHHM5FYbMj7DTuqB8dUuqdqlu/srWaXLvvrRA9MK6J9d2o4
 u9YJspUuXlfMGlfqaLhGZ4oKior1XO2WSRQ93VkAylZemqsefwUlaky0bBsqe81jHClrpARklst
 0LuaBeYNpNdlSxl0QXbEzGybvZX+WtKJ8L03lbCJz8ndvl2h9ahAMtj8xB8ZTPB8YVfrRiicXRI
 OqK7pxpd3r4u2tX0FCg==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afb04d2 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HPkHAgnwbDoOiCnvmVMA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160053
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
Cc: stable@vger.kernel.org
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cdc2627bdaf2..da0b2333a3ca 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2675,6 +2675,12 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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
@@ -2682,12 +2688,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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

