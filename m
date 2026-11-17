Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862ED606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V19wbvnD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VAsoIq2V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFCA10E5C0;
	Tue, 17 Nov 2026 09:40:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0148710E5C0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:40:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH8kQ1n2934209
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ilszVt5EJO8vNtjBpB9Upv9ImKrzH79XOam2vV/Rz8U=; b=V19wbvnD1BZG5TbH
 vgajGS4YB7fiIjwUpJ/5fHnF/EXTc0jt1jO92Kq1zizBG6jgB0LWwq2GUzpzyite
 qiAzIFismlNhqRPoC8Tc5Vp3ZnSuk4Vc+CvHq8F98nx+iQMI2E7+inoYJBCDFqBB
 alV6ja8wD6cG8VcYD+jPgIWj6z8lOARDEjmARANLZAFtufRxORKOQ1ePBm4ovEeJ
 KQLVIlJY7owkw+VbEElMCkgXeMwiDR2AU09OBZ5+zmKcl45WyAoK4kQHyk9/IFLt
 aKbuNbIaW6NnJBTGz9a6Vx1HeSvxJkQ/+4kcGvtAD2AMypq21lPTHbwIERpJRw4O
 wy4Smw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m0ae42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:40:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8bb1a7b0e52so3034770b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794908401; x=1795513201;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ilszVt5EJO8vNtjBpB9Upv9ImKrzH79XOam2vV/Rz8U=;
 b=VAsoIq2V6sDq+JAqtrW5Hc3iPR44kH4CKPmz/SlyMVmGwQx0C/NttMjkolhPX9xyUs
 7xqHhtOX7cjjrGuENDK8M3VpitYlQv2H4uzgrH+g4F7VGTDSzgeDhC2twOjbd1q4L7vU
 vpvdsactN9vx0g3A7mgT8lL5t5wS0TO7MnoN/4oEtzQNuNy6K8OiObPvUWzfzJNknLUw
 lYjBcB3a1pvfZejfyK17eadbt5o10ps9g7yd7Md/SaeIQA7CVi9e97S2r7OyNDBiYhG+
 jmWZl9TAM42XiZoSHYfydES5b6ydmNFiLoK+dA10aEiHqLY2bn5ZHmT3b2eoXTvFddaG
 4Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908401; x=1795513201;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ilszVt5EJO8vNtjBpB9Upv9ImKrzH79XOam2vV/Rz8U=;
 b=re7qGK/9CkV3iK1dTy+HA8x/UARGn80UXOwlQ1uOpvACSueaovrrQwH+Lx0/OgrMfO
 avjKePOfdDAQKl+ewd+DbNmx8E1hQYzmHr5i1TQLWAtyygEy+vkv0GhlzpyfVzbsjuZh
 /7m9m3m32IC3LzkkDwYP9+w2m+q/y05c/Qt3NKlBnN96Gj9ZOekobXnrpAZ3HMm4HZ3x
 SbtnNLkeNMPwo1gv9TE354kTrL/yprtYCL6F4v48LtZxELNsRBd7XXR3dHHMv87W+k1K
 EAgzT81ke3Tlr7WVuHqUmTom47q0RIoUR7aWYkCgoRVZFOhyaCwSh2kj+6OV6N7Jb4yq
 A8kw==
X-Forwarded-Encrypted: i=1;
 AL+hErEtUBR9PWSDk2PVnvqvwi08uhR+W1OiE6M71N8E/Zpq6sDpSWIOQz/YwNwrpDzvoOoFgHUQn7hbV54=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/GhtvRGfH+U4+41VjqNm8bvX5pw88D9Bf9YkdP/vtRDcOKVzuU
 MS8M/fdfSOiJeC0ja5VsyfQceULnrX0G31l4nPgJS41h7pt7mVKG9YUxNPimg4J2QHVjiV3IcHW
 DSMm2784xGOP2JZ4hwg90V0/MmjkfU4rcjHIXl18iK3WAE/cLPiqWUTpd+vQ801CyBKvDAeI=
X-Gm-Gg: AYBFou15wOZBqVYIkcIfJPh+Erj1rj6swam9ouBuZHJThN5bQbluib8pUDdJUR1nHtU
 geG4kIRamos/+tegd2mMYMUa7wc5zE5JwfUtPGFDfchPrPOGg+binaH2LrrOwmH7xctVY1mdxOz
 DJt27ZMtjXeNsryNyiIJNgEuwh98NrwU4PcuSnRkA35LKy5oyVxfEg2CMMekHcgMpn62PPc4CDV
 5ISe+PGkiPV/FBqFN0fbXr4yAeHKCLcobSmKlMfhvihgD+9LtFQ4vXeIZA/1FbNuP+nTIMxv/Xp
 pxDhSjTQc+TiQgp+XTrHof03AstNXZj2yb2IgAMnh19fjmKUHLdWKBXrgNIFczVZIabZc+zaQPj
 chdyhpOpq3xFGhL7nJ6Ngf2uqhGrIOIQlk68n7sXOUedm1QR5hONGB/MBpQ==
X-Received: by 2002:a05:6a20:d74c:b0:3e0:d508:59a6 with SMTP id
 adf61e73a8af0-3f7a71a6635mr11751764637.13.1794908400573; 
 Tue, 17 Nov 2026 01:40:00 -0800 (PST)
X-Received: by 2002:a05:6a20:d74c:b0:3e0:d508:59a6 with SMTP id
 adf61e73a8af0-3f7a71a6635mr11751734637.13.1794908400074; 
 Tue, 17 Nov 2026 01:40:00 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc160bfabsm5299078a12.4.2026.11.17.01.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:39:59 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 15:09:46 +0530
Subject: [PATCH v4 2/3] misc: fastrpc: drop the DSP-response reference on
 channel removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-interrupted-invoke-v4-v4-2-2320a8a7eda2@oss.qualcomm.com>
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
In-Reply-To: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfX/dko630mdgdx
 tWfGbG75Z/IruH6VqzIvZbihvpf1q/Y1qzbWTB4HNdGf5A4AvMGq10KX8cWtQ5g8HR9nL41mlkh
 ZFdrkQ4pb+QvHki3+h+HC58C2R2zVh0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfX+7PR2Tduhbun
 pl54OJkTS0w92kDtpB8m3rO9TKIrsLRZ/H5M84LlfJsJy3oB1EkwhqdyfvaW1RZhWtGty/ruDmi
 AdB3AkWPDXYs49QZuQYeL2YHYgW/uHO8Q5HO41cVzg91jvCKEnnj7RclnR6/hNtH/su4QoVRlvl
 XF94oNAnvq2FyUxSiYlhaiaUGFAsSj3Q/uJIcAXPCN99lzlUL+BwzFsaFnAFkEs+V1+uyCwwCBm
 28gBIg+qSBHvhbX18tA3tyMnJx+KS9LabOe5JnLhrOIpfL5rLc8U6eJPfCHLYaKCH81QXWkdrfG
 t6SHLVRkT0C5zv9s4/flmwxnJDTgWoirhosFP7u5KBDRNuVGAsJywrOWyNZUyUd3Ngo6U+v0V+c
 2XZH/ZxrYDaqE1zNDLz9pGl7YZjfa2uBHzUG/fKdSA1qQrkfTjpTQe3qjWlIyw8M+aPNKQ6/23N
 KboUELFkh7/nGSrjl4A==
X-Proofpoint-GUID: A7xd39-4uWfuf25BHRJUB5dT4udFf5j5
X-Proofpoint-ORIG-GUID: A7xd39-4uWfuf25BHRJUB5dT4udFf5j5
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afc20f1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lRMAZjgjxHAodmaZVVUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170038
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

fastrpc_invoke_send() takes a second reference on the invoke context
before calling rpmsg_send(), to be dropped later by whichever side
consumes the eventual DSP response: fastrpc_rpmsg_callback() for a
real reply, via schedule_work(&ctx->put_work).

fastrpc_notify_users(), called from fastrpc_rpmsg_remove() when the
rpmsg channel goes away (e.g. on subsystem restart), only completes
each pending context with -EPIPE so its waiter can return - it never
schedules the matching put. Since the channel is gone, no response
will ever arrive to trigger it through the normal callback path
either. Every context that was genuinely in flight (successfully
sent, not yet answered) at the time of an SSR therefore leaks that
second reference, and with it the context, its DMA maps, and the
reference it holds on fl and cctx.

Schedule the same put_work that a real response would have
triggered, exactly as fastrpc_rpmsg_callback() does. rpmsg guarantees
.callback and .remove are mutually exclusive for a given device, so
there is no concurrent real response that could race with this.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@kernel.org
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index bb0c304196..c5c3679f87 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2835,6 +2835,13 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	list_for_each_entry(ctx, &user->pending, node) {
 		ctx->retval = -EPIPE;
 		complete(&ctx->work);
+		/*
+		 * fastrpc_invoke_send() took a second reference for the
+		 * DSP response that will now never arrive since the
+		 * channel is gone; schedule the matching put the same
+		 * way a real response would via fastrpc_rpmsg_callback().
+		 */
+		schedule_work(&ctx->put_work);
 	}
 	spin_unlock(&user->lock);
 }

-- 
2.34.1

