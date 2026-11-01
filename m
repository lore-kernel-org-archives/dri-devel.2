Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4607606ECF5
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cTsDdANT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R7hIX5rl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BC310EABC;
	Sun,  1 Nov 2026 22:25:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75D410E4E9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:25:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KKDWQ1454583
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TMXROfr2xHOgjJmbefdl1cTbIPgTcNigGaWQDjsDPKE=; b=cTsDdANT+CVHpJ7n
 TF/0dr51+Vp1UOKcp3hMzxcH0SjtquH3VxObwlXrk8sXfjI5uk9Cfrz76gVYie83
 HuSmlU16MGwJcu1aOYl2LzcoDUVs2nUkVAqqn4uERduj/Q/Fr8tdQSkhqUqgLJaw
 NfPHoJc0GME1WGWhkI6kuvGeqTZk4NfAgusNS6EwlMEWp4vFPpPtL53ZncOjFmom
 hqvzkJmkCeTAi/aPhQ4agQIs3LqLk7eSfd7o7JLhqUaEB1LFNkxgYI7soCiPGDSB
 WCFJTuK8r2V67XHicUtZdvfQM95rPUbIXWIBOa1Eb+qTwCebxEVYZaqH9/oFKuHb
 j6wyDw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfvduh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:25:06 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso3436137c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571906; x=1794176706;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TMXROfr2xHOgjJmbefdl1cTbIPgTcNigGaWQDjsDPKE=;
 b=R7hIX5rlarkuDrFVg4C1Sw/R2ddFN4IdNrzKngqSEk8/joLBATXMCebIR7ClNWbaQN
 OPhuNwU1nIc87P3frZSOQYyvhwfsL+QDdjg1/dMqmUVuuWelRuUeCH3v2aw912e5t50d
 7ACDlxRYNFap3jjWlC4LIKn9Hvwe/GIdlA2Nmr+mkQcsxe3GBj2k0TX1Yyh8MbB/8WRX
 gkpuqoOVcfZ7sStf1ll4uNQpB6mccgabp+dJ6x18zuHZn4b27SYgeb11LaZT3dNTk2eB
 4kg3m8d2Qb3RuSBINMM85O/QhR73ByIaourRCNJz+uQQijinq05rylTJkwT23n49F9Hd
 3Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571906; x=1794176706;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TMXROfr2xHOgjJmbefdl1cTbIPgTcNigGaWQDjsDPKE=;
 b=yHQXwU09dPIMEB3+gYH/SJUfk6UIzH/HE/Aml5g2rNtfSPEYAbtSCRDua1suu0dENd
 yUx7V+1Z+pGjarZRI3JvGEFaxpSBCQ0O1BLIs7KrFZlv1o0fZimbC+Hsvp6450LSYMoQ
 SsKKaVOdlgm1tnlGCYij558IJgUuzbvMG50ZG85ZmYst+l2GUlkAXOByYZp/J9SuYUQn
 Ah/AVMb8Roj8TTrAlRulmDh8YFYwauJ/XmAFqfwDlnfnG7i3wW3HeRWJgApOe5CyjvDT
 NomsSB03/yXmkCrjf0+E8hrZeT1krTeQYvNTpo86ZiDxw+89y7xmtdeo5MnMXyLtVqZ8
 i+mw==
X-Forwarded-Encrypted: i=1;
 AKwUvByltUCPz3vhODaSbSoZQPTa5jl91vw80bBk6tpQj7ZApULKBiiPPuYDnBZLpBrfLZ7JeNlWfW4Qgss=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLADJacDxrkqQjn/3LySoM1uNouDj1S4OmYu/GtVdqV5e3D1M1H
 xcda8TApOjmxlNnylqXA8m7YthWfh01X0vy8qQfKXJ8fuffLTwSJNsGR2dE7rlJfeQu70mcD1ak
 3AMT7X8OcXXNaogeFlIvElOF1MKS4Nvkbcjy3jswEx+nK1EHWsCJF8YXq5xXptJDCyha2j90=
X-Gm-Gg: AYBFou3EgQzqk6h4eMj7kiUXqxerFIb45F7XC+HHZO2sIGWR3F9fsEH3q9jsclnOv7N
 IC5u5QhBtP46mYb007yxfDjGHvIz2a9twCJ9YwrFeHmcICwc75Us7XKWkuBUSIctceEUCaZFgnX
 PADLRd1mFLgRADcJaFuog5wyCMAw7S1BhcAe+jUUc8cyaz+8p0LTqnp20RXcaZsAUv719x3la+R
 baHughoPlSmHmCoTbVDyErZrs+dy9MlTsAHqUMB2c0PzMzIxDehX1YN+bmMwiwjNh7wUIw3J7Xc
 WOLF71yod0zKfOnkaDatBGQNiyhDomL2DX9zQC3EP2jnECy9Zvz0nCuwKZPRCIGeJLt9wDbd0tI
 aDoUefU5Az7n2xZuXvQUw17Kfy79DZXl7TcpDsdpY0fVIjgoPHGaEmdlSOBCTy5PgTaYwG9kRnB
 7p3FlyGQ==
X-Received: by 2002:a05:701b:271a:b0:187:c940:21b7 with SMTP id
 a92af1059eb24-1ac5c55491bmr10364541c88.9.1793571905369; 
 Sun, 01 Nov 2026 14:25:05 -0800 (PST)
X-Received: by 2002:a05:701b:271a:b0:187:c940:21b7 with SMTP id
 a92af1059eb24-1ac5c55491bmr10364505c88.9.1793571904702; 
 Sun, 01 Nov 2026 14:25:04 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:25:04 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:33 +0530
Subject: [PATCH v4 20/25] accel/qda: Add remote attach to root and sensors
 protection domains
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-20-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=8348;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=IpYZwb3O28tUIvOFQ4pGq7xILpeDE1PdYhg3VDvGSE0=;
 b=OY1kuQblYQsTaKRNHoXh3Km9t9aloNB+ftcoXFkOIiNT6eldptBfN2TChamNI9OdRzVeVwEm6
 lXI1WUnY9ezDfLjm4sn8ZlWmBVZfwXfdhhlSR/2blbgoMy2j5w/vVXE
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX6WsfAydffskj
 gdR//lSgc2vzkhevmThHHdIo7NaOgGW0kkQD433OVr0IVsvNZE4Gm6nHSniLV/VG7J5VWl8LIyV
 7BGiII/fQ+RaiYypk5y1SR9DOYDUTYU=
X-Proofpoint-GUID: mZNxg4j6ViqbYfAVn-NY_tWzT6eWZdPk
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae7bc42 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lFo-LjhiPMwFrTsBpIEA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: mZNxg4j6ViqbYfAVn-NY_tWzT6eWZdPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXwwRZlCBmuEzw
 d+SnZY8suX5OxBc7QIG5lpDHuq5W+0OLWavnc9aP0+PEVs55apEH9oeKl6exlH7XEeomgi1hmoV
 QHJCngw90fIUBpg0D66inKkpBnLI3UF+/H+fCwClc7Iu33xRbAWCKXZ2QD3f76kUoLrYVj1OAl2
 aTRSXtesK9rVL1zOq+6nzBX1utHhhIh0HxRZBQ4Vt5mc4YVE/r9AT8rvwzIqpWQ2mdQPsJDZ0CU
 mOxKnPhB5mnc0YZVn0FhMk+zLlDLa9BjpaLtcUKRSEdFrKsSJGIOGBbem+RwROiUVx/qXIix++N
 94qR04kP9Y1EKBoSdLE5RTiUTDcF+q02Rs8mQHyjkWgzDEAR8JdnWqLWilM+EtyIZHNyIV+GUsj
 wJxJE+27Wbz2f+Wl3hYaaDhJLrL/Y8F5v37zxw05dN6edleOYQg+IjGxcnF5yKf9riPexqIW53d
 wl15PDXgYTn10uKa0hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010089
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

Some daemons need to reach a protection domain that already exists on
the DSP, rather than create a new user process with
DRM_IOCTL_QDA_REMOTE_SESSION_CREATE. Add an ioctl that attaches the
calling session to one, directing every later request on that session
at the attached domain.

Root and Sensors PD attach send the same message to the DSP, which
tells them apart by the domain the request is directed at. The session
only switches domain once the DSP has accepted the attach, and attaching
is refused once a process has been created on the session.

Attaching requires CAP_SYS_ADMIN.

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c     |  1 +
 drivers/accel/qda/qda_fastrpc.c | 13 +++++++++----
 drivers/accel/qda/qda_fastrpc.h |  2 ++
 drivers/accel/qda/qda_ioctl.c   | 36 ++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h   |  1 +
 include/uapi/drm/qda_accel.h    | 25 +++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index c5b41b869692..1e72dce769b9 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -127,6 +127,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_CREATE, qda_ioctl_init_create, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MMAP, qda_ioctl_mmap, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MUNMAP, qda_ioctl_munmap, 0),
+	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_ATTACH, qda_ioctl_attach, 0),
 };
 
 static const struct drm_driver qda_drm_driver = {
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index b35604fce630..5bf55b7953c8 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -819,15 +819,15 @@ static int qda_fastrpc_use_elf_obj(struct qda_fastrpc_invoke_ctx *ctx,
 }
 
 /*
- * INIT_RELEASE packed layout:
+ * INIT_RELEASE and INIT_ATTACH packed layout:
  *   [0] remote_session_id	sizeof(int)	IN
  */
-static int qda_fastrpc_prepare_args_release_process(struct qda_fastrpc_invoke_ctx *ctx)
+static int qda_fastrpc_prepare_args_session(struct qda_fastrpc_invoke_ctx *ctx, u32 rmid)
 {
 	struct qda_gem_obj *kernel_gem;
 	int err;
 
-	ctx->sc = QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_RELEASE, 1, 0);
+	ctx->sc = QDA_FASTRPC_SCALARS(rmid, 1, 0);
 	ctx->handle = QDA_FASTRPC_INIT_HANDLE;
 
 	err = alloc_kernel_args(ctx, 1);
@@ -1211,7 +1211,12 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx,
 
 	switch (ctx->type) {
 	case QDA_FASTRPC_RMID_INIT_RELEASE:
-		err = qda_fastrpc_prepare_args_release_process(ctx);
+		err = qda_fastrpc_prepare_args_session(ctx, QDA_FASTRPC_RMID_INIT_RELEASE);
+		break;
+	case QDA_FASTRPC_RMID_INIT_ATTACH:
+		/* The DSP tells the domains apart by the one the request is directed at */
+		ctx->pd = *(int *)argp;
+		err = qda_fastrpc_prepare_args_session(ctx, QDA_FASTRPC_RMID_INIT_ATTACH);
 		break;
 	case QDA_FASTRPC_RMID_INIT_CREATE:
 		/* The new process is in the user PD, and so is the request creating it */
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 10a99bbfa383..29e1c3946d60 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -44,6 +44,7 @@ struct qda_session;
 #define QDA_FASTRPC_MAX_CRCLIST		64	/* CRC list entries */
 
 /* Methods of the initialisation handle */
+#define QDA_FASTRPC_RMID_INIT_ATTACH		0
 #define QDA_FASTRPC_RMID_INIT_RELEASE		1
 #define QDA_FASTRPC_RMID_INIT_MMAP		4
 #define QDA_FASTRPC_RMID_INIT_MUNMAP		5
@@ -59,6 +60,7 @@ struct qda_session;
 /* Protection domains a request can be directed at */
 #define QDA_ROOT_PD			0
 #define QDA_USER_PD			1
+#define QDA_SENSORS_PD			2
 
 /* Largest ELF image a process may be created from */
 #define QDA_FASTRPC_INIT_FILELEN_MAX	(4 * 1024 * 1024)
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 999afa9e70c2..9b8cccfea1e3 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -121,6 +121,8 @@ static int qda_fastrpc_invoke(u32 type, void *data, struct qda_session *session)
 	if (type == QDA_FASTRPC_RMID_INIT_CREATE) {
 		qda_session_set_init_mem(session, ctx->init_mem_gem_obj);
 		WRITE_ONCE(session->pd, QDA_USER_PD);
+	} else if (type == QDA_FASTRPC_RMID_INIT_ATTACH) {
+		WRITE_ONCE(session->pd, ctx->pd);
 	}
 
 out_put:
@@ -174,6 +176,40 @@ int qda_release_dsp_process(struct qda_dev *qdev, struct qda_session *session)
 	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_RELEASE, NULL, session);
 }
 
+/**
+ * qda_ioctl_attach() - Attach to a DSP-resident protection domain
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_remote_attach)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_remote_attach *args = data;
+	struct qda_session *session = file_priv->driver_priv;
+	int pd;
+
+	if (args->pad)
+		return -EINVAL;
+
+	switch (args->pd_type) {
+	case QDA_ATTACH_ROOT_PD:
+		pd = QDA_ROOT_PD;
+		break;
+	case QDA_ATTACH_SENSORS_PD:
+		pd = QDA_SENSORS_PD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (READ_ONCE(session->init_mem_gem_obj))
+		return -EBUSY;
+
+	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_ATTACH, &pd, session);
+}
+
 /**
  * qda_ioctl_mmap() - Map a buffer into the DSP's address space
  * @dev: DRM device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 9b868189df0a..f6f5d64e36ce 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -19,6 +19,7 @@ int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_p
 int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_session_init_create(struct qda_session *session, struct qda_init_create_args *create);
 int qda_session_mem_map(struct qda_session *session, struct qda_mem_map_args *args);
 int qda_session_mem_unmap(struct qda_session *session, struct drm_qda_mem_unmap *unmap);
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 43598ddef461..59ad5b8cc997 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -19,6 +19,7 @@ extern "C" {
 #define DRM_QDA_REMOTE_SESSION_CREATE	0x04
 #define DRM_QDA_REMOTE_MMAP		0x05
 #define DRM_QDA_REMOTE_MUNMAP		0x06
+#define DRM_QDA_REMOTE_SESSION_ATTACH	0x07
 
 #define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
 					 struct drm_qda_query)
@@ -35,6 +36,9 @@ extern "C" {
 					 struct drm_qda_mem_map)
 #define DRM_IOCTL_QDA_REMOTE_MUNMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_MUNMAP, \
 					 struct drm_qda_mem_unmap)
+#define DRM_IOCTL_QDA_REMOTE_SESSION_ATTACH					\
+	DRM_IOW(DRM_COMMAND_BASE + DRM_QDA_REMOTE_SESSION_ATTACH,		\
+		struct drm_qda_remote_attach)
 
 /* Request types for drm_qda_mem_map.request */
 #define QDA_REQUEST_MMAP	1	/* Map a whole buffer */
@@ -203,6 +207,27 @@ struct drm_qda_mem_unmap {
 	__u64 size;
 };
 
+/* Protection domains for drm_qda_remote_attach.pd_type */
+#define QDA_ATTACH_ROOT_PD	1
+#define QDA_ATTACH_SENSORS_PD	2
+
+/**
+ * struct drm_qda_remote_attach - Parameters for attaching to a DSP protection domain
+ * @pd_type: QDA_ATTACH_ROOT_PD or QDA_ATTACH_SENSORS_PD
+ * @pad: Must be zero
+ *
+ * Binds this file to a protection domain that already exists on the DSP,
+ * instead of creating one with DRM_IOCTL_QDA_REMOTE_SESSION_CREATE. Every
+ * later request on the file is directed at it. Fails with EBUSY if a process
+ * has already been created on the file.
+ *
+ * Requires CAP_SYS_ADMIN.
+ */
+struct drm_qda_remote_attach {
+	__u32 pd_type;
+	__u32 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

