Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CB606ECDD
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=chCscoj5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dZ9xcyzV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6FE10EAA0;
	Sun,  1 Nov 2026 22:25:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7744E10EAA0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:24:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KJw9Q1808353
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JXcq3OQUvWyIpJUnnELONyNVisA+F1dcac0kLyCJwRU=; b=chCscoj5g/oZ3PBX
 TNX5FbiM6g/rpeSORbnHLOZ/8e4qajm5FKUUu3WI+ahkkeGB2cffb578CdQz5VcL
 EAQFR/xFx/HNaUSh2rRhHdKf0YB/VL44+IMWfDl1HqnX82oTDNuhRVmsWR++Atn/
 fsp9SaRsUISj3+21Z5z0k0yozaomEU+u+03ucEtnstofP6/1+0Y6l1uWaIdZTq/L
 2PvlffC2wrlYUEA4WfjKguNSM6Fycu36Gu1mk/oAy6wV6fzJSwqkbTpyv860lEox
 z3nh9K7tw7T+Bg7gIMIoe2jyhEaPlxxKAM+ztbUIyT9bCFMpyud/7vMuGrcjIIl8
 kbRiHQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkmq1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:24:56 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so3662314c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571895; x=1794176695;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JXcq3OQUvWyIpJUnnELONyNVisA+F1dcac0kLyCJwRU=;
 b=dZ9xcyzVl7kSHffGUcPPQIWlfOi/A/ZtiC4r5NqV+MZiTdsKIjkWFf6w2lLLuqctk0
 1+77uXoVWAfQL5owGn/4y7Dk27Tx5ZiBrOfUdy/OlPLW3ZAMgBgAkQ99lp22yPtTUGvM
 5F/iq6YZYo5/Hp3aqcGQYbv/xdgloTgDVY7y+no+mF2aYv66zijrmXp0RxrXUNS8s2DC
 hLe84WU7aePnMf4lWnPpSSu/3z6cpz058wNd7vUWvQTdpYbvoBsv4KW/3FKFMBYQemLG
 abGtX7dcb2JgpevbRk/oLrXD5zAt7zxaIh3kBAjCInmubygmGwCwSA+BQl+sOPXxZ9hN
 erbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571895; x=1794176695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JXcq3OQUvWyIpJUnnELONyNVisA+F1dcac0kLyCJwRU=;
 b=d5v/DnlNZgOahRakrrrt5n3VhSxIkpcwcEDmmmY9gTMU6XrTzsGp9uS/bdPL0BAMeJ
 oFCrX72Plq+8cSEKIQel7EPMesi1O6FCW+0I79+ork56t+maW0Uv9DAQ0OCdUWdPi4oI
 /mo2dxXZiyWvH+yayWwDqVvi8n9yH1fBSfuar1/qwWn+cjzHOjW0wn3N/RLOOvKY3P4g
 Tb4jZO8BU2lGAPXb+w9UmGzSa4LZZ457xyt/RB0C51oAhUcGHpOGzi0APdhdWPU0ff7q
 Lk4d3Nzd3Dk+L8EJNO1P8gxIFyGfGxwInRia05HPFDxB0fW8RdduLKmx3mGDJIhHQCtF
 UtDA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBPVdL6CT2S1JLOVWV5iluUTXfiHQxvIuUULVIQTwCCvdm3vbQptjEsL5sAyQT/lT7K4OK0qxRKVQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIpeyS9cdyVBKvqVGWLlJDwr/jA6lSpNuXQ89pv/QeiCLRYqRzA
 3zRTKyQB5oq6ANDZpZyggg7hnDffJdU4OYtulBlNQT+T9oW9dVEZbubmimEdySXbrXUgkNe9wNf
 cqQVSp5BNvmnDLdM27A8tsUDTuplPHf7getLW5S/mT09DUCfauw+4SUfWQT4fdsk8CLBVpAw=
X-Gm-Gg: AYBFou1KaE3do5ypFJlLmQpGmXd9IdOeFHM3S/KWQiBJooh1La+PE0uQWQQO92jHsvD
 azqeq65D9Z8UKG4so4tsdCfTqoGfRhx6hva5E8v7gwU5X6cKb+B7GkGKTNOiIlEAXwXx+k8SE54
 2LJdxGThFIgO9aMK85kZohK4OB5K7cChijQKpyGMHI72hc2ySH/sFj4ZTd69l/OifR/TTWqcxOQ
 uyqa4xnvwnyFH4UiK7h15dK3P8Dj2IJcOFTGOG1TeRTJ8iFjC68hleaSmBqUYvzp4YcUSkhRxTr
 YZ4QDyrkmtLXb1cMLfHg/umo+D7vQMkDqVnhkd+w6yGf2XWOssraWbbFKaJGn+pkLZ+FUj57UOu
 QLpX8ZSaJR491NnQIqR81HTjd1qmwjGnTW06+riO1JeoC9xbXYvzlC6WprhC6W3axOo1Oy6hrSf
 SvVkJFiw==
X-Received: by 2002:a05:7022:2203:b0:18d:c38c:bcc9 with SMTP id
 a92af1059eb24-1ac56e8a821mr18673814c88.3.1793571894812; 
 Sun, 01 Nov 2026 14:24:54 -0800 (PST)
X-Received: by 2002:a05:7022:2203:b0:18d:c38c:bcc9 with SMTP id
 a92af1059eb24-1ac56e8a821mr18673756c88.3.1793571894099; 
 Sun, 01 Nov 2026 14:24:54 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:24:53 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:32 +0530
Subject: [PATCH v4 19/25] accel/qda: Add remote memory map and unmap to the
 legacy shim
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-19-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
In-Reply-To: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=24614;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=TOGGfjmnBJev5B3DLutwHE6RpFN7eDoMJKEkgcbs7gM=;
 b=zXQqd7GbKuBMB/YYu4bpnWpp9Ln9KZRtl42qtN7nE4Yfd2O0TkcfjABCvgPaoQu67CfxhFFpe
 NVS++Ur6byPBUKPJFUExXfX34/lZhmQee4Slv4piBVI64ACotphd8pm
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-GUID: ZfuKm9KiNL88wI-FYuDmd5pBSxlFi8HY
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae7bc38 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=iy6etLm9HCI9rwuQ78IA:9 a=GVGhT3VO6GXzNuf7:21
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXxP88BwEeR2PJ
 3wq58rbedSr49dGWIzuvMalAeHPBHKesCK/8lD9DlcdO1PiYw054hAYm6IrGs373fDMvhJLr3Gm
 Tlx1od8TYBpHLLrn3KjZ43m8diok8U0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX/9UCbICPopKN
 B55YMDnttLhLfmabfliHk9c9fm2fO9OszqJvzUtCUXi0I+7Z7+roeBiOeM0XFrxfVrbqXx+gY/g
 YjHGiGhmMDP4XgQDepJtD2Sfe7UKWyNMiyfVAA6QS4srH8mHEab7SX1OMeYgVEF9ir0NPMgi5jv
 l7Jr+yyh1S+1ZDASRbfsXoV3bYcXIzvy6op7SIMnVFN95fnGVtk5m1bsvI8dXsZ5WfuqZDV7pYq
 9s/X8PlABOvSH65fnVAaBiSHLW0A2BjuzvGsOtpdQOWB4ViMeelUdCU5jFvL6FKlbAia1Q+v6wy
 yCUppuBvzjA0wNkmR2Bo6iElP5YnAnwhEy8S4JAcEWTi2WMhk7cC5qKsQ5Jq4d9P+gKocX6KBHd
 9e31dB2o8GGk4WdQN1xkcgaTCX/E7QM18ffKfPEOk4gnIUM3R+f5/xFkRws2T7BQevngccxmKXQ
 c39s+Sw4/BO8RgMp5Qg==
X-Proofpoint-ORIG-GUID: ZfuKm9KiNL88wI-FYuDmd5pBSxlFi8HY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010089
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

From: Ekansh Gupta <ekangupt@qti.qualcomm.com>

Applications written for the /dev/fastrpc-* interface name buffers by
file descriptor rather than GEM handle, and have no handle table to
keep a mapped buffer alive between the map and unmap calls. Serve the
four legacy map and unmap ioctls by importing the descriptor as usual,
and track the live mapping on the open file so the buffer stays
referenced for as long as the DSP has it mapped, exactly the job a GEM
handle does for the native UAPI.

The buffer reaches the shared mapping code already imported, in place
of a handle. As for a buffer named by handle, it must be mapped in the
calling session's context bank, since a descriptor can name a buffer
another session exported, and the requested length must fit in it.

Two lists are kept per open file, since the two legacy unmap paths name
a mapping differently: MUNMAP only ever gets back the address map
returned, while MEM_UNMAP uses the file descriptor as the identifier
the DSP tracks the buffer by. A mapping is recorded with the address
and length it was made with, and an unmap must match them: the length
the DSP is asked to unmap is the recorded one, and MUNMAP with a
different length is refused. The same descriptor cannot be mapped
twice with MEM_MAP, as the DSP could not tell the two apart on unmap,
and a negative buffer offset is refused.

If the DSP cannot unmap a mapping, it stays recorded so the unmap can
be retried. If the mapping cannot be reported back to the caller, it is
taken down again rather than left unreachable. Mappings still
outstanding when the file closes are unmapped on the DSP before the
buffers they hold are released, so the DSP is never left using memory
that has been freed.

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
 drivers/accel/qda/qda_fastrpc.c      |  40 ++++--
 drivers/accel/qda/qda_fastrpc.h      |  17 +++
 drivers/accel/qda/qda_fastrpc_shim.c | 262 +++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.c        |  64 ++++++---
 drivers/accel/qda/qda_ioctl.h        |   4 +
 drivers/accel/qda/qda_legacy_ops.c   |  77 ++++++++++
 drivers/accel/qda/qda_legacy_ops.h   |  11 ++
 7 files changed, 447 insertions(+), 28 deletions(-)

diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index dbd14cd07cb2..b35604fce630 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -633,7 +633,7 @@ void qda_fastrpc_flush_pending(struct qda_dev *qdev)
  */
 void qda_fastrpc_return_result(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 {
-	struct drm_qda_mem_map *margs = argp;
+	struct qda_mem_map_args *map_args = argp;
 	struct qda_fastrpc_map_rsp_msg *rsp;
 	int idx;
 
@@ -650,7 +650,7 @@ void qda_fastrpc_return_result(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 
 	rsp = (struct qda_fastrpc_map_rsp_msg *)
 	      ((u8 *)to_qda_gem_obj(ctx->gem_objs[idx])->virt + ctx->args[idx].offset);
-	margs->vaddrout = rsp->vaddrout;
+	map_args->map.vaddrout = rsp->vaddrout;
 }
 
 /**
@@ -935,19 +935,33 @@ static int qda_fastrpc_prepare_args_init_create(struct qda_fastrpc_invoke_ctx *c
  * buffer is held by the context until the request is done, so that closing its
  * handle meanwhile cannot free memory the DSP is being told to map. The
  * region must fit in the buffer, as the DSP would otherwise map past its end.
+ *
+ * A caller with no handle table supplies the buffer already imported. It is
+ * checked as a buffer named by handle would be: an fd can name a buffer that
+ * another session exported, which resolves to the original object, still
+ * mapped in that session's context bank.
  */
-static int setup_mmap_pages(struct qda_fastrpc_invoke_ctx *ctx, struct drm_qda_mem_map *margs,
+static int setup_mmap_pages(struct qda_fastrpc_invoke_ctx *ctx, struct qda_mem_map_args *args,
 			    struct qda_phy_page *pages)
 {
+	struct drm_qda_mem_map *margs = &args->map;
 	struct qda_gem_obj *qda_gem_obj;
 	int err;
 
-	if (!margs->handle)
-		return -EINVAL;
+	if (args->obj) {
+		if (to_qda_gem_obj(args->obj)->iommu_dev != ctx->session->assigned_iommu_dev)
+			return -EACCES;
 
-	err = get_gem_obj_from_handle(ctx, margs->handle, &ctx->map_obj);
-	if (err)
-		return err;
+		drm_gem_object_get(args->obj);
+		ctx->map_obj = args->obj;
+	} else {
+		if (!margs->handle)
+			return -EINVAL;
+
+		err = get_gem_obj_from_handle(ctx, margs->handle, &ctx->map_obj);
+		if (err)
+			return err;
+	}
 
 	qda_gem_obj = to_qda_gem_obj(ctx->map_obj);
 	if (margs->size > qda_gem_obj->size)
@@ -967,7 +981,8 @@ static int setup_mmap_pages(struct qda_fastrpc_invoke_ctx *ctx, struct drm_qda_m
  */
 static int qda_fastrpc_prepare_args_map(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 {
-	struct drm_qda_mem_map *margs = argp;
+	struct qda_mem_map_args *map_args = argp;
+	struct drm_qda_mem_map *margs = &map_args->map;
 	struct qda_fastrpc_map_req_msg *req;
 	struct qda_gem_obj *kernel_gem;
 	u8 *gv;
@@ -996,7 +1011,7 @@ static int qda_fastrpc_prepare_args_map(struct qda_fastrpc_invoke_ctx *ctx, void
 	req->vaddr = margs->vaddrin;
 	req->num = sizeof(struct qda_phy_page);
 
-	err = setup_mmap_pages(ctx, margs, (struct qda_phy_page *)(gv + off_pages));
+	err = setup_mmap_pages(ctx, map_args, (struct qda_phy_page *)(gv + off_pages));
 	if (err)
 		goto out_put;
 
@@ -1020,7 +1035,8 @@ static int qda_fastrpc_prepare_args_map(struct qda_fastrpc_invoke_ctx *ctx, void
  */
 static int qda_fastrpc_prepare_args_mem_map(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 {
-	struct drm_qda_mem_map *margs = argp;
+	struct qda_mem_map_args *map_args = argp;
+	struct drm_qda_mem_map *margs = &map_args->map;
 	struct qda_fastrpc_mem_map_req_msg *req;
 	struct qda_gem_obj *kernel_gem;
 	u8 *gv;
@@ -1056,7 +1072,7 @@ static int qda_fastrpc_prepare_args_mem_map(struct qda_fastrpc_invoke_ctx *ctx,
 	req->num = sizeof(struct qda_phy_page);
 	req->data_len = 0;
 
-	err = setup_mmap_pages(ctx, margs, (struct qda_phy_page *)(gv + off_pages));
+	err = setup_mmap_pages(ctx, map_args, (struct qda_phy_page *)(gv + off_pages));
 	if (err)
 		goto out_put;
 
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 889b41dc20b0..10a99bbfa383 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -360,6 +360,23 @@ struct qda_init_create_args {
 	struct drm_gem_object *elf_obj;
 };
 
+/**
+ * struct qda_mem_map_args - Kernel-side arguments for mapping a buffer into the DSP
+ *
+ * Wraps the UAPI arguments so that a caller with no handle table, such as the
+ * legacy shim, can pass an already imported buffer.
+ */
+struct qda_mem_map_args {
+	/** @map: Mapping parameters; @map.vaddrout is filled in on success */
+	struct drm_qda_mem_map map;
+	/**
+	 * @obj: Buffer to map, in the session's context bank, or NULL if
+	 * @map.handle names it. Borrowed: the caller keeps its reference for
+	 * the length of the call.
+	 */
+	struct drm_gem_object *obj;
+};
+
 struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev);
 void qda_fastrpc_context_free(struct kref *ref);
 void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda_fastrpc_shim.c
index 4a2ba20ee01a..c46d2de4f581 100644
--- a/drivers/accel/qda/qda_fastrpc_shim.c
+++ b/drivers/accel/qda/qda_fastrpc_shim.c
@@ -8,7 +8,9 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/limits.h>
+#include <linux/list.h>
 #include <linux/miscdevice.h>
+#include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
@@ -21,9 +23,29 @@
 #include "qda_fastrpc.h"
 #include "qda_legacy_ops.h"
 
+/*
+ * A buffer the DSP has mapped for an open file. A legacy session has no
+ * handle table, so this is what keeps the buffer alive for as long as the
+ * mapping lasts, the job a GEM handle does for the accel UAPI.
+ *
+ * Plain mappings are found by the address map returned, which is all
+ * MUNMAP carries. Attribute-based ones are found by the fd, which doubles
+ * as the identifier the DSP tracks the buffer by.
+ */
+struct qda_shim_mapping {
+	struct list_head node;
+	u64 key;
+	u64 vaddr;
+	u64 size;
+	struct drm_gem_object *obj;
+};
+
 /* State of one open /dev/fastrpc-* file */
 struct qda_shim_file {
 	struct qda_session *session;
+	struct mutex maps_lock;
+	struct list_head mmap_list;
+	struct list_head mem_map_list;
 	/* Opened through the /dev/fastrpc-<dsp>-secure node */
 	bool secure_node;
 	/* Properties of the qda_shim_dev this file was opened on */
@@ -79,6 +101,83 @@ static struct drm_gem_object *shim_import_fd(struct qda_session *session, s32 fd
 	return obj;
 }
 
+/* Takes ownership of @obj on success; on failure the caller still owns it */
+static struct qda_shim_mapping *shim_mapping_add(struct qda_shim_file *sf,
+						 struct list_head *list, u64 key, u64 vaddr,
+						 u64 size, struct drm_gem_object *obj)
+{
+	struct qda_shim_mapping *m, *new;
+
+	new = kzalloc_obj(*new);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	new->key = key;
+	new->vaddr = vaddr;
+	new->size = size;
+	new->obj = obj;
+
+	guard(mutex)(&sf->maps_lock);
+
+	list_for_each_entry(m, list, node) {
+		if (m->key == key) {
+			kfree(new);
+			return ERR_PTR(-EEXIST);
+		}
+	}
+	list_add_tail(&new->node, list);
+
+	return new;
+}
+
+static struct qda_shim_mapping *shim_mapping_detach(struct qda_shim_file *sf,
+						    struct list_head *list, u64 key, u64 vaddr)
+{
+	struct qda_shim_mapping *m;
+
+	guard(mutex)(&sf->maps_lock);
+
+	list_for_each_entry(m, list, node) {
+		if (m->key == key && m->vaddr == vaddr) {
+			list_del(&m->node);
+			return m;
+		}
+	}
+
+	return NULL;
+}
+
+static void shim_mapping_attach(struct qda_shim_file *sf, struct list_head *list,
+				struct qda_shim_mapping *m)
+{
+	guard(mutex)(&sf->maps_lock);
+	list_add_tail(&m->node, list);
+}
+
+static void shim_mapping_free(struct qda_shim_mapping *m)
+{
+	drm_gem_object_put(m->obj);
+	kfree(m);
+}
+
+/* The DSP unmap comes first: the buffer must outlive the DSP's use of it */
+static void shim_mappings_release(struct qda_shim_file *sf)
+{
+	struct qda_shim_mapping *m, *tmp;
+
+	list_for_each_entry_safe(m, tmp, &sf->mmap_list, node) {
+		list_del(&m->node);
+		qda_legacy_ops_table.munmap(sf->session, m->vaddr, m->size);
+		shim_mapping_free(m);
+	}
+
+	list_for_each_entry_safe(m, tmp, &sf->mem_map_list, node) {
+		list_del(&m->node);
+		qda_legacy_ops_table.mem_unmap(sf->session, m->key, m->vaddr, m->size);
+		shim_mapping_free(m);
+	}
+}
+
 static int qda_shim_open(struct inode *inode, struct file *file)
 {
 	struct qda_shim_node *snode = container_of(file->private_data, struct qda_shim_node,
@@ -97,6 +196,9 @@ static int qda_shim_open(struct inode *inode, struct file *file)
 		return err;
 	}
 
+	mutex_init(&sf->maps_lock);
+	INIT_LIST_HEAD(&sf->mmap_list);
+	INIT_LIST_HEAD(&sf->mem_map_list);
 	sf->secure_node = snode->secure;
 	sf->secure_channel = snode->sdev->secure_channel;
 	sf->unsigned_support = snode->sdev->unsigned_support;
@@ -110,8 +212,10 @@ static int qda_shim_release(struct inode *inode, struct file *file)
 {
 	struct qda_shim_file *sf = file->private_data;
 
+	shim_mappings_release(sf);
 	qda_legacy_ops_table.release(sf->session);
 	qda_legacy_ops_table.session_destroy(sf->session);
+	mutex_destroy(&sf->maps_lock);
 	kfree(sf);
 
 	return 0;
@@ -191,6 +295,156 @@ static long qda_shim_init_create(struct qda_shim_file *sf, void __user *argp)
 	return err;
 }
 
+static long qda_shim_mmap(struct qda_shim_file *sf, void __user *argp)
+{
+	struct qda_shim_mapping *m;
+	struct fastrpc_req_mmap args;
+	struct drm_gem_object *obj;
+	int err;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	obj = shim_import_fd(sf->session, args.fd);
+	if (IS_ERR(obj))
+		return PTR_ERR(obj);
+	if (!obj)
+		return -EINVAL;
+
+	err = qda_legacy_ops_table.mmap(sf->session, obj, args.vaddrin, args.size, args.flags,
+					&args.vaddrout);
+	if (err) {
+		drm_gem_object_put(obj);
+		return err;
+	}
+
+	m = shim_mapping_add(sf, &sf->mmap_list, args.vaddrout, args.vaddrout, args.size, obj);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		goto err_unmap;
+	}
+
+	if (copy_to_user(argp, &args, sizeof(args))) {
+		m = shim_mapping_detach(sf, &sf->mmap_list, args.vaddrout, args.vaddrout);
+		if (m) {
+			qda_legacy_ops_table.munmap(sf->session, m->vaddr, m->size);
+			shim_mapping_free(m);
+		}
+		return -EFAULT;
+	}
+
+	return 0;
+
+err_unmap:
+	qda_legacy_ops_table.munmap(sf->session, args.vaddrout, args.size);
+	drm_gem_object_put(obj);
+
+	return err;
+}
+
+static long qda_shim_munmap(struct qda_shim_file *sf, void __user *argp)
+{
+	struct fastrpc_req_munmap args;
+	struct qda_shim_mapping *m;
+	int err;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	m = shim_mapping_detach(sf, &sf->mmap_list, args.vaddrout, args.vaddrout);
+	if (!m)
+		return -ENOENT;
+
+	if (m->size != args.size) {
+		shim_mapping_attach(sf, &sf->mmap_list, m);
+		return -EINVAL;
+	}
+
+	err = qda_legacy_ops_table.munmap(sf->session, m->vaddr, m->size);
+	if (err) {
+		shim_mapping_attach(sf, &sf->mmap_list, m);
+		return err;
+	}
+
+	shim_mapping_free(m);
+
+	return 0;
+}
+
+static long qda_shim_mem_map(struct qda_shim_file *sf, void __user *argp)
+{
+	struct qda_shim_mapping *m;
+	struct fastrpc_mem_map args;
+	struct drm_gem_object *obj;
+	int err;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.offset < 0)
+		return -EINVAL;
+
+	obj = shim_import_fd(sf->session, args.fd);
+	if (IS_ERR(obj))
+		return PTR_ERR(obj);
+	if (!obj)
+		return -EINVAL;
+
+	/* Reserved before the DSP is asked, so the same fd cannot be mapped twice */
+	m = shim_mapping_add(sf, &sf->mem_map_list, args.fd, 0, args.length, obj);
+	if (IS_ERR(m)) {
+		drm_gem_object_put(obj);
+		return PTR_ERR(m);
+	}
+
+	err = qda_legacy_ops_table.mem_map(sf->session, obj, args.flags, args.attrs, args.offset,
+					   args.vaddrin, args.length, args.fd, &args.vaddrout);
+	if (err) {
+		m = shim_mapping_detach(sf, &sf->mem_map_list, args.fd, 0);
+		if (m)
+			shim_mapping_free(m);
+		return err;
+	}
+
+	scoped_guard(mutex, &sf->maps_lock)
+		m->vaddr = args.vaddrout;
+
+	if (copy_to_user(argp, &args, sizeof(args))) {
+		m = shim_mapping_detach(sf, &sf->mem_map_list, args.fd, args.vaddrout);
+		if (m) {
+			qda_legacy_ops_table.mem_unmap(sf->session, m->key, m->vaddr, m->size);
+			shim_mapping_free(m);
+		}
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static long qda_shim_mem_unmap(struct qda_shim_file *sf, void __user *argp)
+{
+	struct fastrpc_mem_unmap args;
+	struct qda_shim_mapping *m;
+	int err;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	m = shim_mapping_detach(sf, &sf->mem_map_list, args.fd, args.vaddr);
+	if (!m)
+		return -ENOENT;
+
+	err = qda_legacy_ops_table.mem_unmap(sf->session, m->key, m->vaddr, m->size);
+	if (err) {
+		shim_mapping_attach(sf, &sf->mem_map_list, m);
+		return err;
+	}
+
+	shim_mapping_free(m);
+
+	return 0;
+}
+
 static long qda_shim_invoke(struct qda_shim_file *sf, void __user *argp)
 {
 	struct qda_legacy_invoke_arg *largs;
@@ -262,6 +516,14 @@ static long qda_shim_dispatch(struct qda_shim_file *sf, unsigned int cmd, void _
 		return qda_shim_alloc_dma_buf(sf, argp);
 	case FASTRPC_IOCTL_INIT_CREATE:
 		return qda_shim_init_create(sf, argp);
+	case FASTRPC_IOCTL_MMAP:
+		return qda_shim_mmap(sf, argp);
+	case FASTRPC_IOCTL_MUNMAP:
+		return qda_shim_munmap(sf, argp);
+	case FASTRPC_IOCTL_MEM_MAP:
+		return qda_shim_mem_map(sf, argp);
+	case FASTRPC_IOCTL_MEM_UNMAP:
+		return qda_shim_mem_unmap(sf, argp);
 	case FASTRPC_IOCTL_INVOKE:
 		return qda_shim_invoke(sf, argp);
 	default:
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 17d1b488b4a9..999afa9e70c2 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -185,42 +185,74 @@ int qda_release_dsp_process(struct qda_dev *qdev, struct qda_session *session)
 int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 {
 	struct drm_qda_mem_map *map_req = data;
+	struct qda_mem_map_args args = {
+		.map = *map_req,
+	};
+	int err;
+
+	err = qda_session_mem_map(file_priv->driver_priv, &args);
+	if (err)
+		return err;
 
-	switch (map_req->request) {
+	map_req->vaddrout = args.map.vaddrout;
+
+	return 0;
+}
+
+/**
+ * qda_session_mem_map() - Map a buffer into the DSP's address space
+ * @session: Session to map for
+ * @args: Mapping parameters; @args->map.vaddrout is filled in on success
+ *
+ * For sessions with no handle table to name the buffer by, such as those of
+ * the legacy shim, which supply @args->obj.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_session_mem_map(struct qda_session *session, struct qda_mem_map_args *args)
+{
+	switch (args->map.request) {
 	case QDA_REQUEST_MMAP:
-		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MMAP, data, file_priv->driver_priv);
+		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MMAP, args, session);
 	case QDA_REQUEST_MEM_MAP:
-		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MEM_MAP, data,
-					  file_priv->driver_priv);
+		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MEM_MAP, args, session);
 	default:
 		return -EINVAL;
 	}
 }
 
 /**
- * qda_ioctl_munmap() - Remove a buffer's mapping from the DSP's address space
- * @dev: DRM device structure
- * @data: User-space data (struct drm_qda_mem_unmap)
- * @file_priv: DRM file private data
+ * qda_session_mem_unmap() - Remove a buffer's mapping from the DSP's address space
+ * @session: Session the mapping belongs to
+ * @unmap: Which mapping to remove
  *
  * Return: 0 on success, negative error code on failure
  */
-int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv)
+int qda_session_mem_unmap(struct qda_session *session, struct drm_qda_mem_unmap *unmap)
 {
-	struct drm_qda_mem_unmap *unmap_req = data;
-
-	switch (unmap_req->request) {
+	switch (unmap->request) {
 	case QDA_REQUEST_MUNMAP:
-		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MUNMAP, data,
-					  file_priv->driver_priv);
+		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MUNMAP, unmap, session);
 	case QDA_REQUEST_MEM_UNMAP:
-		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MEM_UNMAP, data,
-					  file_priv->driver_priv);
+		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MEM_UNMAP, unmap, session);
 	default:
 		return -EINVAL;
 	}
 }
 
+/**
+ * qda_ioctl_munmap() - Remove a buffer's mapping from the DSP's address space
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_mem_unmap)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	return qda_session_mem_unmap(file_priv->driver_priv, data);
+}
+
 /**
  * qda_ioctl_invoke() - Run a method on the DSP
  * @dev: DRM device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 9c053349c3fa..9b868189df0a 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -8,7 +8,9 @@
 
 #include "qda_drv.h"
 
+struct drm_qda_mem_unmap;
 struct qda_init_create_args;
+struct qda_mem_map_args;
 
 int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
@@ -18,5 +20,7 @@ int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *f
 int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_session_init_create(struct qda_session *session, struct qda_init_create_args *create);
+int qda_session_mem_map(struct qda_session *session, struct qda_mem_map_args *args);
+int qda_session_mem_unmap(struct qda_session *session, struct drm_qda_mem_unmap *unmap);
 
 #endif /* __QDA_IOCTL_H__ */
diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_legacy_ops.c
index 2b3b3f4fb246..ea815ab0c52a 100644
--- a/drivers/accel/qda/qda_legacy_ops.c
+++ b/drivers/accel/qda/qda_legacy_ops.c
@@ -75,6 +75,79 @@ static int legacy_release(struct qda_session *session)
 	return qda_release_dsp_process(session->qda_dev, session);
 }
 
+static int legacy_mmap(struct qda_session *session, struct drm_gem_object *obj,
+		       u64 vaddrin, u64 size, u32 flags, u64 *vaddrout)
+{
+	struct qda_mem_map_args args = {
+		.map = {
+			.request = QDA_REQUEST_MMAP,
+			.flags = flags,
+			.vaddrin = vaddrin,
+			.size = size,
+		},
+		.obj = obj,
+	};
+	int err;
+
+	err = qda_session_mem_map(session, &args);
+	if (err)
+		return err;
+
+	*vaddrout = args.map.vaddrout;
+
+	return 0;
+}
+
+static int legacy_mem_map(struct qda_session *session, struct drm_gem_object *obj, u32 flags,
+			  u32 attrs, u32 offset, u64 vaddrin, u64 size, s32 dsp_handle,
+			  u64 *vaddrout)
+{
+	struct qda_mem_map_args args = {
+		.map = {
+			.request = QDA_REQUEST_MEM_MAP,
+			.flags = flags,
+			.attrs = attrs,
+			.offset = offset,
+			.dsp_handle = dsp_handle,
+			.vaddrin = vaddrin,
+			.size = size,
+		},
+		.obj = obj,
+	};
+	int err;
+
+	err = qda_session_mem_map(session, &args);
+	if (err)
+		return err;
+
+	*vaddrout = args.map.vaddrout;
+
+	return 0;
+}
+
+static int legacy_munmap(struct qda_session *session, u64 vaddrout, u64 size)
+{
+	struct drm_qda_mem_unmap unmap = {
+		.request = QDA_REQUEST_MUNMAP,
+		.vaddrout = vaddrout,
+		.size = size,
+	};
+
+	return qda_session_mem_unmap(session, &unmap);
+}
+
+static int legacy_mem_unmap(struct qda_session *session, s32 dsp_handle, u64 vaddr, u64 size)
+{
+	struct drm_qda_mem_unmap unmap = {
+		.request = QDA_REQUEST_MEM_UNMAP,
+		.dsp_handle = dsp_handle,
+		.vaddr = vaddr,
+		.size = size,
+	};
+
+	return qda_session_mem_unmap(session, &unmap);
+}
+
 /*
  * As the GEM_CREATE ioctl, but exporting a DMA-BUF rather than installing a
  * handle: a session the shim created has no DRM file to hold handles, and the
@@ -120,6 +193,10 @@ const struct qda_legacy_ops qda_legacy_ops_table = {
 	.session_destroy = legacy_session_destroy,
 	.init_create = legacy_init_create,
 	.release = legacy_release,
+	.mmap = legacy_mmap,
+	.mem_map = legacy_mem_map,
+	.munmap = legacy_munmap,
+	.mem_unmap = legacy_mem_unmap,
 	.alloc_dmabuf = legacy_alloc_dmabuf,
 	.import_dmabuf = legacy_import_dmabuf,
 	.invoke = legacy_invoke,
diff --git a/drivers/accel/qda/qda_legacy_ops.h b/drivers/accel/qda/qda_legacy_ops.h
index 05bd1f806c9a..e3126ac10507 100644
--- a/drivers/accel/qda/qda_legacy_ops.h
+++ b/drivers/accel/qda/qda_legacy_ops.h
@@ -35,6 +35,17 @@ struct qda_legacy_ops {
 			   u32 filelen, u32 attrs, u32 siglen);
 	/** @release: Release the session's DSP process, if it has one */
 	int (*release)(struct qda_session *session);
+	/** @mmap: Map a buffer into the DSP's address space */
+	int (*mmap)(struct qda_session *session, struct drm_gem_object *obj, u64 vaddrin,
+		    u64 size, u32 flags, u64 *vaddrout);
+	/** @mem_map: Map a region of a buffer with explicit SMMU attributes */
+	int (*mem_map)(struct qda_session *session, struct drm_gem_object *obj, u32 flags,
+		       u32 attrs, u32 offset, u64 vaddrin, u64 size, s32 dsp_handle,
+		       u64 *vaddrout);
+	/** @munmap: Undo a mapping made with @mmap */
+	int (*munmap)(struct qda_session *session, u64 vaddrout, u64 size);
+	/** @mem_unmap: Undo a mapping made with @mem_map */
+	int (*mem_unmap)(struct qda_session *session, s32 dsp_handle, u64 vaddr, u64 size);
 	/** @alloc_dmabuf: Allocate a buffer and export it as a DMA-BUF */
 	struct dma_buf *(*alloc_dmabuf)(struct qda_session *session, u64 size);
 	/** @import_dmabuf: Map a DMA-BUF into a session's context bank */

-- 
2.34.1

