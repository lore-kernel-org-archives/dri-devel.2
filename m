Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I7Nixanx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bNzippbY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C9D10E0B6;
	Thu, 22 Oct 2026 02:36:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B71710E0B6
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M0jHYx2022268
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4OsuM9apoqZ
 E7bpRFpKXdoXy2y1FoU/7d0f47HGR6Tg=; b=I7NixanxowPcgaV0ODpgIzjjkIu
 fKSD60Gkx2hC4kPyZxVSkLO23G52PVzlAUktWNQP56JJ7u+ZrHY6uJXznyapXgcy
 5jNteNPRD8B/29anyczmyqvSgZpDjR+OQ+KpFoMBSY1VnZZar9FF1EetiSbICWlv
 g0It0ayVEsQeI2y0Cku1An+hxC+Iv7yDnzE5BdHPhntzPazP6yKYS5be5hJIDVpi
 m2LaMCk4hH/m1cJ3H9hUiVMDrzNrYUe+oWZ2CNtqjU2k0t1+kE/FuS0k/Y6r71i0
 nOx2P7q3dI/+pHgDXAKOSVCIJymLHmDrpj2k0R7zJRC+cHjMS5taSewH4IQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2jqb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad98380ccfso1316369a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 19:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792636544; x=1793241344;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4OsuM9apoqZE7bpRFpKXdoXy2y1FoU/7d0f47HGR6Tg=;
 b=bNzippbYrcnJq4PImMCpDlZusU3/cKWQbeaJDs9GVyHMfRIcq0QBnowWOjnlnRiCTv
 ub6nt1FhSqxz4f1s8as1Zv2dkNkUxr3mEMzu59I2xUqYrSZ6wLc8+lcacfnBwFCHGhKb
 6FgGp2RpnNYxn2pIMS8lZieweoep9Qh1PtQFjjfxw1PYI2WpwgC4Yw8XMcQRssNM8sQs
 peMn+NsJYcfYVzM7QBWjlxjQzgaVkf1oE0p5EqiLKM6epllTfsNVhXaWfI3fPt9Jp0kn
 VAfr8/sd9CCSKpsqoPpgYgJ0y7Rw1sCbnTt6zygkK+RDCaeLk9noHvPV5i+g4UtZFhWg
 naiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792636544; x=1793241344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4OsuM9apoqZE7bpRFpKXdoXy2y1FoU/7d0f47HGR6Tg=;
 b=mnqyf0kSZWUpoapHqjmkCfq/ixcJtNH7tYFo2eVthjjcKdJHjL38imGfDC4mFukvg6
 zskEo+7h3+2EqAtJartoPwr8hMgZuvHU6YJEzLinciAkrKhk9Uw1LrxD+XygsqeQReOB
 0lObfjJggjViEpBSdYk/1BAwqpYY7ZUOGcEnT7TqTha5d2N+Kb9o67RHwZv60LKhVgVz
 J+YsKGzzMwNM/dVSYkOzqmO2a7Rf6NdiX6f8nNRgGKvdh4OWrMq25WZlt0WZmoeRrZ8g
 /rSB1KDzOs607APl+X7QRKfJPF4occ8xZ9OoaGJDaxsCV60OxzfBISRuQF0O0UU2ptUm
 clWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGDfsTF4tbRjnOxwsnInLI+5WlF7LaNcdbhfmz0k1hqo4+3U6JHWuDzVZYv4PYq8Q3BPyqHLHSVco=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK7krU0zFWzNIVch31eGIklunDqqFfrzb46sFfOAk9qwf39NNkS
 bNoAembZR2U2ZCN0+pm1YNDPXdVtjiUvVOSgJ3BfYAvW4okA+13XZ95Fp7OupJaAhsB4nafEX5z
 fnMK1AmhIemQ829mB2xlA+/97MFLUyn8QlODHbi/d69uaQzUfVVZDNdkqtD+YU1/Lcat4ihM=
X-Gm-Gg: AYBFou2mxj2PG4bPePNcvfpBRMdj69R1gobxnhsdqyvG75j4W02RVxOKywRjQJSBWOp
 h9UKPkikCcwVtROEiQabvEQxxGhNZrwYb+5VyZuL/gBWabmiYrXgnCNqTFHxrSDxDG/+4s/mGer
 o59Fu06xFqVBnb6EemHLfW+sNg4HxvxcIvf/bcoQqxgUlf8jY2ORePN6gKJvhluI/FbtualaTsM
 b7DdFmVevPwvnbH5YC5qipPt0YaA97yoAR2cmlRlE0i+9Wpzy5lGr8iHpWRwSknuQIAMeJfL12G
 e2Aw856DMGcknAvAfY/jIZiiR80X5bcT4DQPv+gU3ASHQncCWDJ1H/UoNYEUxPBBglBBjiOR+Nx
 ypyEee8A3TEdvUhVYhbwsKm7uYFRkYUrEeni1Lmhb9Tk8A2yGkSzn7ryNy7/fbqMD/6rwSsV9
X-Received: by 2002:a17:90b:5908:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3ad86f44c42mr3219180a91.10.1792636543676; 
 Wed, 21 Oct 2026 19:35:43 -0700 (PDT)
X-Received: by 2002:a17:90b:5908:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3ad86f44c42mr3219156a91.10.1792636543226; 
 Wed, 21 Oct 2026 19:35:43 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada488550esm1959935a91.3.2026.10.21.19.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 19:35:42 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: [PATCH v2 1/2] misc: fastrpc: wake poll-mode waiters on SSR
Date: Thu, 22 Oct 2026 10:35:30 +0800
Message-Id: <20261022023531.465-2-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022023531.465-1-jianping.li@oss.qualcomm.com>
References: <20261022023531.465-1-jianping.li@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxMCBTYWx0ZWRfX56Omz2irGvqa
 U/Mu+mqk4gxS3m/qmLxfCPuPlbRXuLq+Y97TMjuDIK55cVfkLVuTMUvMXpZkycfvUYauQglIHEU
 Ur7Vy5oCihKmdW5q4BLQ+jYhRMd+6Mc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxMCBTYWx0ZWRfX9HnozImt7w66
 3y3iaS8kZPV5IDXSAGXNgMTHbqoQ19bcsB/9ORq+SFOxF/KiGw7YsN0JlynpreQu0JjamJfLzXN
 ngrxl5ZC4U2E0U5IkY5LldsCZaHPxC1s5VYQkF+bXJG8bdC9us4dzhnZtguuKP7ldesOTi2Fbh3
 1TsAF8HL9sPArspcyaUxmmeeepV/T5PG/3BPa2Stvk0LQ4jIxKi6cNGGx6ixHWamovfrn9lhl7w
 0HV7vZppkbLnbUDswJWG8qac5hfexjvQDIJQSWm/r7fXngiToCxOGzTP1Hc+PogUyabUF4I3yFn
 svgiTmBy1QvHrHnJdkdt7zOFQcRnlRl4tAm06KGbWKq0pxS+RFI0tbBdX025qZjsKyWacOiTTCd
 tK/pdELZviVVbbZ7dsmr5tWN6htBx1wbb+Do0p0otLA4QK53vbe7JzATGT3PFFqDV5hkpUsJs5u
 RvcdAwDaevUOvm/Ikdw==
X-Proofpoint-ORIG-GUID: Ehoakt12YHhzr2zb-pnp6AYA6v7gmn9Z
X-Proofpoint-GUID: Ehoakt12YHhzr2zb-pnp6AYA6v7gmn9Z
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad97680 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lWAaA6wL40FgRWs9ITUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220010
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

fastrpc_notify_users() sets ctx->retval to -EPIPE and completes
ctx->work for every pending and interrupted context, which is enough to
release a thread blocked in fastrpc_wait_for_response().

A thread using polling mode does not wait on that completion. It spins
in poll_for_remote_response(), whose exit condition is:

  (val == FASTRPC_POLL_RESPONSE) || ctx->is_work_done

Since the DSP is already down, it will never write FASTRPC_POLL_RESPONSE
into the poll address, and is_work_done is left untouched by
fastrpc_notify_users(). The thread therefore keeps spinning until
FASTRPC_POLL_MAX_TIMEOUT_US expires instead of bailing out immediately.

Worse, the poll address lives inside ctx->buf, so a polling thread that
has not been told to stop is still reading a buffer that the SSR
teardown path is about to reclaim.

Set is_work_done along with retval so polling waiters observe the
termination on their next iteration, exactly like completion waiters do.

Fixes: 96e62cc0a84d ("misc: fastrpc: Add polling mode support for fastRPC driver")
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..d201f26d8e46 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2663,6 +2663,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	spin_lock(&user->lock);
 	list_for_each_entry(ctx, &user->pending, node) {
 		ctx->retval = -EPIPE;
+		ctx->is_work_done = true;
 		complete(&ctx->work);
 	}
 	spin_unlock(&user->lock);
-- 
2.43.0

