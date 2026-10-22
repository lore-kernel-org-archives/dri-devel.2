Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182D606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sok4x+qO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Trv9Sg7r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B06112418;
	Thu, 22 Oct 2026 09:09:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EFA10E32E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M702bT3076364
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=j3WJZdu5775elj6uuKLwnG
 5OWtcyQAMV793EswPClxw=; b=Sok4x+qOHyVxuPipE7GtNfO1/rPu2zg79DNu8N
 hnplTNRMR+l5OdyGhr1eeeGo5Q3ZjY8oZtB3xF17wF99fhHKnihjZqA93HKg1IXn
 XuFboaCcdZKCTRGO617gnO8qFLmOgDMt9fr3A4rPtt45Ra+0e4jy/JtjaPTr6IZL
 avn71avb6o5huyFX2wJozZeuctvcpKUllYJgMw1uoZzVG76uILTeu50jul9GISA3
 OWSJTiXw7SmlZUy7nl4W43bsp63nYHqw0SEIpKE2ToYsWfmLHZqxIgzIdjy4TNNP
 xT80qtksputk4foZPzsZkJaV/C8HW0wQ3HqkhoJArnKbjWnQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a1kyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3813479eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792660169; x=1793264969;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j3WJZdu5775elj6uuKLwnG5OWtcyQAMV793EswPClxw=;
 b=Trv9Sg7rOBoauiUO7efSkloRNaEvyNfBXIQB68Uw+PlsrMhmnXRutBskcsS909lSNv
 PC2g7jy46K7oHZPmJm1wWvknXTdBx8F7pwqK6aZ+peMa6GOcDzN7EFZTp+y8d/9xWAFD
 wL2eY1HqYUtaiwwk3j97DA1PE6osWF0j0BVAC/nWp9rknzvL/0tlQ/euWupAFvC6QRMg
 uTD//ByfrJkKaGgrUzHR7+E4kNEV1UztQUx8kdtXV0hWV4PD8hP5NDhC+sWT0GNnR0xS
 MkxGu8w0YJXK8nyu2li/MDE8uqNmf+MbZ8n/rvZC8lNYDpbAYJYUJ/yGR2CKodSm0QOA
 ydzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660169; x=1793264969;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j3WJZdu5775elj6uuKLwnG5OWtcyQAMV793EswPClxw=;
 b=yotbRjbBEicnadXdMcAR2O5DYxYS0RVfzx+CWoQajvSp7TB/PRWj1cjl/IrQPs+JZe
 NfrwKAldB46YhHF8a/M8M5WydY4mIHqyBpCPfcb/l5F0mwt9YVO12LNHFB0Dug0TEQcU
 WeuUmZsjgELMYj+D3ubtRN8+jS5rMreYYgR82AMjp37wVxCbdn9FGOd31yC/NQ52oXhm
 j9HXIrGV4pQTsslcWzuGZlkQdst2nyv1oJknpGVfH6RFs1iGF+yQa/O5kCiA//dSSorH
 OFKy66vl/J0OaJ30tTqFrIulWZO3eI/7fyUCtTuf9RheNXfwzf/7J6lQFCam01RKvA2i
 ZSEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiNHNE7nDsVr5lSuwvt0pdP50hLOvGSlAHyQCIT/Bo2lifqw8uwf8em0Vdf/TNlbVvCiceb8iAePE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICpZqa1oUaH1KWyHPjlRfLbM9XnDdHDDGtCWZ7nLqR7owNVDZm
 Js7uZ91Q4hNkJPptrZJQS8GwvlYIziXiTQZG5hXNj9T02imH9wxO+Izose259rZNFcdt0nXzbDX
 VjzPgc9AMlpWAXnz+g288/qatPgLbTvSbnNYef60WM4Sq2+CiqkSqGZJ2KFJHhcP8zKycBCs=
X-Gm-Gg: AYBFou3I8pviXBla57K+VzeC7r9YC7BRGW/eP1N+KemRTI+DIrN8zmseV7dRDcZm7Nj
 OIpwKEIfxTUg6Qm43h+5ox52m9d3o5r6va7Ro+8fOathFmorx35BDICGeovwlgz7nIs2Z0J99Hd
 Jo66/ruLISWDgimxmz36Q3TMvTb1IfRI4q+6nM3Y+gxfYLycbz2WeW4m1zItC8VXxr/UoiysKzM
 DPGwzB5BUQ7jP5Gk7/T5ezvTYlCwMHludyIo/Wo2w2D/aQJMtRdTXvN5t42hH5PGlPDE076qV3n
 0rQ+VtCfxnDGnHS8zStdzUErqLxY7DdyEYuJdAcK3Gb/M4Y3hhHC1oilR1cDgXQ1+vIRGHmtI7o
 U5XghH7C5iiBnDYtrYlGAexguj86Qb2yM
X-Received: by 2002:a05:701b:428c:20b0:143:54c6:6a5 with SMTP id
 a92af1059eb24-190a7e0c231mr5790182c88.37.1792660168755; 
 Thu, 22 Oct 2026 02:09:28 -0700 (PDT)
X-Received: by 2002:a05:701b:428c:20b0:143:54c6:6a5 with SMTP id
 a92af1059eb24-190a7e0c231mr5790148c88.37.1792660168220; 
 Thu, 22 Oct 2026 02:09:28 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a180b9esm20475694c88.4.2026.10.22.02.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:09:27 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Date: Thu, 22 Oct 2026 14:38:46 +0530
Message-Id: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7S2WoC/22PPW7DMAyFr2JoLgPKimXLU+9RZNAP1QhoIke0j
 RaB717ZGbp0IfhI8HuPT8FUErEYm6cotCZO+V5F+9YIf7X3T4IUqhYtthpNqyBansvkYSrZEcT
 0TQwKvTQDug5Ji3o5FToW9fDj8tKFHkuFz6/hH7ta7eTKhrBMwMR7AgayrfXWVq45j+tBdZYJf
 L7d0jw2Q+xDROxs3+mzC32MtQvWeIVDFzpnjI6SpBa7/zXxnMvP8eQqjwC7q0SU//6zSkCQqtf
 BKDc4Re+Z+fRY7Nduf6pFXLZt+wVfI7UNPQEAAA==
X-Change-ID: 20260923-fastrpc-probe-fixes-30c1980b50e6
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660163; l=1910;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=GFQalxNhnzpwWjm7qg2xNhpXW9tdjjxqTNEL/AZf5UM=;
 b=QbQSyyVdl4WlLYx8U2VU5VSCc6okBD3GFA81JkdZS7FkrpJp5C7ukMRM06GCf1gxI48cZynGC
 1mR5saLcRfgAHEHis2LoIX8F7z/NPrUQYV2Ly1h+RU6Svnjk7MlaVCO
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX4bjPJng74cko
 ozkyBGHJkHkRkHrjdQfZVBZr7ZE7mkznUEXXOjcL0IL2kQcM5phF+Ufzboe/eTDjELLg5YKI5TZ
 OMFr8D/6NCVOnJNCiWlnze2x0NrGtfzqAhKQAFu2QEH0JwGkJ1chOR+gs65BHXFfwI3z3ndz3Na
 m/cF+sFSTR+mwkiF4sTOF6dN1eFj4GLJqSYPjK/DiIfvRDi1NehnmnVOxth1+BTC/itbWCm1W4L
 YKWNqlMdnC3stGT4nLFhHdEyOvX7e26ClGF5I5GfKST3zIXcUqwW+pDFukiq32LXil61N+Ks2ZJ
 hbtHr/W6etuvOi31cHfNdzQ86nMWXY4HYNgeQ1clA2hNKKj/H5frPzfYvnFEi9M7xUBLRvvSBl9
 ZDY7hsXpw/W6bD4JzeB78GQiA93zCJmt82bqZUcQqm0qtXm5OCAa/N5KBw4V+Bj4Ue+k3z8O3kj
 3aFq5QOCdi6hsXbSPQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfXzFs3GcLydU5c
 kX4Qrfm1t/9d24bfYptAiX7N14PLgnTMIaf0ifDtw7X9/epmbKFQ69zUx86HDzHmZNFthjC/hZt
 z0LIJUj04CjyGRuPtWRFl6Beq/SMULU=
X-Proofpoint-GUID: n8lPp5YaFeGLujZk37TfNLCAijHOgODW
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ad9d2c9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z9hRlnAjW1SqKzzyvooA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: n8lPp5YaFeGLujZk37TfNLCAijHOgODW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220036
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

This series fixes two races in fastrpc_rpmsg_probe() that can be
triggered when userspace opens a fastrpc device node concurrently with
the rpmsg probe sequence.

fastrpc_device_register() calls misc_register() before the channel
context is fully initialised. A concurrent open() in that window hits
kref_get() on a zero refcount, and because fastrpc_cb_devices_create()
has not yet run sesscount is 0, the error path calls kref_put() on the
saturated refcount, triggering kfree() of the channel context. A
subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
freed spinlock, causing a kernel panic. A NULL dereference in the
fastrpc_device_open() error path when cctx->rpdev is concurrently
cleared by fastrpc_rpmsg_remove() is also addressed.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v2:
- Add Cc: stable to both fixes
- Free cctx via fastrpc_channel_ctx_put() in the probe error path
- Clear rpdev and wake pending users there, as remove() does
- Move fastrpc_notify_users() above probe
- Link to v1: https://lore.kernel.org/r/20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com

---
Vinayak Katoch (2):
      misc: fastrpc: fix NULL rpdev dereference when session alloc fails
      misc: fastrpc: fix init ordering race in rpmsg probe

 drivers/misc/fastrpc.c | 95 +++++++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 39 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6
prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v6
prerequisite-patch-id: c8b4a3873f9cf0d69beff0f608933ae83faa4c47
prerequisite-patch-id: 05d9299adf4184e0e56d97dc063ab5bf227cc5a5
prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

