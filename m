Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0E606A334
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MMCeIdX/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BlqWe1ZA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3B310E52A;
	Tue, 17 Nov 2026 09:40:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D181710E52A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:39:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH8NFvw721413
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jkwCDTDY34gysHX4eD/Jtb
 t83iR/Xm5caRAcO2dYSpk=; b=MMCeIdX/qLiJeARaBfQjBVicy9JDQqcVTluqTE
 G3JPO9FlBLxUM8656v6aNX4e3SuaC2KFg1tCW/bSeTg++o+DyYOrgxx1ZMYuzmbW
 wgzKlbDncDj6ZHri3BtcXa2fXw+p47GftulV/i0/vXDz1PAE+ploI357fKG8RLEV
 GcZIph2skaH70mhCiBxzCiBdPPqqh14vPap72N1uS2hD7ri2uQpf3cWC9ZtVSqWF
 Cbgk3AXQt3PYpAosLWehozKze9ZYqn6it2kTlqQHov65tZGpayzh8Ead+wu3uD+q
 WNIgJ1x1PD+I2eBqeEg0i6cN1qTWTtzZBFsctbYL+BeP9eXA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kcc89v4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:39:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so2731085a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794908391; x=1795513191;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jkwCDTDY34gysHX4eD/Jtbt83iR/Xm5caRAcO2dYSpk=;
 b=BlqWe1ZAbdAQH8RT+YzEfOgp9Ikmt9nhhLMXErtUixhuatdsHq/GBcQfvflvhWcgtn
 uofblJSOl8+j/vSMwzjIC66BIBhksmervKptFu+fA4WSpBulqDgsnNKyfwIasYU+l8t0
 DPWrYJZazPRZYcqDLkLKDHOd/Q4hng/vwFGyIuWJrv7I67An/gW9gQuOO3/PZjHrTaOx
 +SJMP8vLZKUM8MbDSxzgbUqz6YNdw1obzUGyIBEV7LhngFc6nqETI/wDtduvkNp31hXJ
 vZv4gbQlyGRT5tTFjHEPo1h5M6xksxsZpSjUzZU1F0UjHuOUQqTfFBGeqAdlkCYGvdsb
 RA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908391; x=1795513191;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jkwCDTDY34gysHX4eD/Jtbt83iR/Xm5caRAcO2dYSpk=;
 b=pUZS+EIAG8snx0XAKXgvVScQz/3GXc6qK3KeCy3hO/YgHDX/r8tI5RYSoMWVej4PvP
 iKk4ZjB6oTy7tjYJqzoh96cpHDbed87XOtVu1TJ0CMiTxcWc2e29WGLgN1g6uwAI1Maz
 xhVj6GpTu+geGoYADy+Mucdus0t/QPCaJ7ODaqVd8S3CWSWnXsoapW/JTBd7pT3o2QSj
 R+nfUA6rB55Nv8svE5wygxY9RwpgbXPd0YTqCV1VHKY1QsEp+CMdDDdMjV41WbhKi9xq
 a0wUCl0qH3r3WU1Ehlea3C2hIhMj57Z1O4IfiMwTNXf0uTv3xvLNl5snjbzXy9qUJb0r
 4btA==
X-Forwarded-Encrypted: i=1;
 AL+hErEnyq3B9p7LcCCSP8+EEn6mmHhsOIIuSjHmk/080WJvgssgCz9TsicT7rQcEjgj/Q4wMH4Slrpxwxs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+N6MmliuIb6lutaH67cgdYUEBEFa3iynQVu9xTq7XEXKpkhpoT
 OeN66HAsQEuyEQc49ZCk4OAYFjRP5PF/SdYADV6SNxM2eTTLXAOHr27NyYnCh5/Gn+bW9kXjCUL
 tyQ8cu/mmVwR2KxfTjqJePPrWxcUCHj5CuaQEbSctfLqtxVGAfI5htgS+oY/QVC+uqd6hiXBu8F
 nTlK8=
X-Gm-Gg: AYBFou2xpjNlLj0urtRQLeDl+/6yPwFBNQHX/pRWBIrIAPF4zj8Nogl+MbQIrzkaVfi
 IoiZs4tq/wiLBxKTY/CR296tY3nKTyiX+A8Q7QwhxXay4O/E2NG2+M2GKAQmzA3LMjLy9zB7awL
 N6wMfvNO88qLTGqzNtjN9rkDYQNxlPtWhubYesRxKVW0DSc6KwpKOgFYEKl+3rMjPQ9qAxwTrZ9
 NvjZOOJzjtmN9qaDsD8JEbll1hXCWEn+KZWiuEagQ24eLIBYh7fMRsOaAprigu23E3l0ReTt8Aq
 WB30MZ/JAhWtn7x194iWjWBHrMbP66WCFl14sH7wdK42CqzQKCQu9vg7blGnP03Y3ksk/PP6b52
 mtPz9hsmBMdVNb88777yB5cC4vLQizvmPtKueOfMr+CJZNr5YgpipdtKgKQ==
X-Received: by 2002:a05:6300:8189:b0:3eb:a628:10e9 with SMTP id
 adf61e73a8af0-3f7a79c61ffmr10478986637.39.1794908391475; 
 Tue, 17 Nov 2026 01:39:51 -0800 (PST)
X-Received: by 2002:a05:6300:8189:b0:3eb:a628:10e9 with SMTP id
 adf61e73a8af0-3f7a79c61ffmr10478956637.39.1794908390903; 
 Tue, 17 Nov 2026 01:39:50 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc160bfabsm5299078a12.4.2026.11.17.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:39:50 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Subject: [PATCH v4 0/3] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
Date: Tue, 17 Nov 2026 15:09:44 +0530
Message-Id: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAg/GoC/yXMSwqEMBCE4atIrw2Y4Iu5yuDCaDnTDkTpxCCId
 zeju/oW9R/kIQxPr+wgQWTPi0so84yGb+8+UDwmkylMrbVuFLsAkW0NGNOOyw8qlmoyqCyaFrZ
 vKX1XwcT73X13j/1mZwzhH6PzvAARkmwQeQAAAA==
X-Change-ID: 20261117-interrupted-invoke-v4-f2e5be78eba8
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfXwmbdQGy2C4AY
 sBBMflBEaZ3eG5yXtb848Lh+49pBOML5TodQl1k4axtXXfbks7c38F3AxjzLSPhrhZx46TdcZjT
 Jzmo32uIXJZGuH0w3ibVn0ll04iH7To=
X-Proofpoint-ORIG-GUID: vZf4QehY_6O58N7OnTVKR0AxliYgqT0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfXweiDC0A6y0wC
 cDP4wTqhtkCy1DszbpL2bj40UAa11OnfUIpKxg93NffUl5xuiqM6xOYqntz2JR+8nh8Kj0b8bWf
 dVHwu6pmtg5rD+owJXPgAzOYlBrPkUJxbZ3FlOdK01KwImRl4qZQpWheFBYaZmqmH2ygLTx0i8f
 OlBtyljrKHIAJAHuD+YrYpxMaiNb7oHSwoupoqLx80wPcAz7Ee9YUoh9V9lAjcNjie/yKkn0q4f
 foq2tKa7gze7CiA/2enqb89qlWtKAlpwXvf5x3R/SxQpPZRWYfYeDPWtIULepjz63d1h8FQjoS2
 CO2e5EN6olOyWa+UgAPTuk5NDonhIzJsOXmt7nj8KbRyYwpzQgUjnpWOgZL51yahjz0C9hXOVSJ
 YTIprFGe7JsxPCIRex9VKmCNFa2liYYZGJVrOzU+/8cuEacCYIY/2Auxunu4FNxchCMuQA4QPKN
 j2nqoDOKxAJfMNHKOfw==
X-Proofpoint-GUID: vZf4QehY_6O58N7OnTVKR0AxliYgqT0C
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afc20e8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=e5mUnYsNAAAA:8
 a=COk6AnOGAAAA:8 a=-vHKDIwpwqHdDy8GyowA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170038
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

This series fixes a context leak and DSP hang that occur when a
fastrpc invoke syscall is interrupted by a signal (patch 3), plus two
independent, pre-existing bugs the refcounting audit for that fix
surfaced along the way (patches 1 and 2).

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
Changes in v4:
- Split the single patch into a 3-patch series. Patches 1 and 2 are
  standalone, pre-existing bugs the refcounting audit for this series
  surfaced - dead code in fastrpc_user_free() and a worker-reference
  leak on SSR for ordinary (never-interrupted) pending contexts - each
  with its own Fixes: tag, landing ahead of the actual
  interrupted-invoke fix in patch 3.
- Fixed a hang inherited from v1-v3: fastrpc_invoke_send() failure
  shared the same bail: label as a post-send wait interruption, so a
  message that rpmsg_send() itself never delivered to the DSP could
  still be parked as resumable, and a retry would then wait forever
  for a response that was never going to arrive. fastrpc_invoke_send()
  failure now gets its own dedicated cleanup path instead, without
  needing an extra flag to tell the two cases apart.
- fastrpc_device_release() now also accounts for a successful
  fastrpc_release_current_dsp_process(): if the DSP confirms it is
  done with the whole process, the worker reference on any parked
  context is dropped immediately instead of always waiting for a
  later event.
- fastrpc_user_free() no longer unlinks fl from cctx->users
  unconditionally at fd close; it now does so only once fl truly has
  no references left, so a context still awaiting a DSP response
  after fd close remains reachable by a later SSR.
- Extended the same unreachable-orphan fix to timed-out kernel
  invokes (-ETIMEDOUT), which had the identical problem on
  fl->pending.
- fastrpc_context_restore_interrupted() now uses kref_get_unless_zero()
  when reclaiming a matched context on retry, closing a race where a
  concurrent drain (SSR, fd close, or a delayed DSP response) could
  already have dropped the context's last reference and be waiting on
  the same lock to unlink it.
- Link to v3: https://lore.kernel.org/all/20261002-anandu-fastrpc-interrupted-invoke-v3-v3-1-31e90439d2ba@oss.qualcomm.com/

Changes in v3:
- fastrpc_context_save_interrupted() no longer drops a reference when
  parking the context, fixing a kref double-put that left the context
  under-refcounted.
- Restoring an interrupted context now matches on both handle and sc,
  not sc alone, so a stale/differently-shaped retry cannot be handed a
  buffer layout it didn't allocate.
- A mismatched handle/sc on retry now falls through to allocating a
  fresh context instead of returning -EINVAL, so a thread issuing a
  different call after an interrupted one is never permanently
  wedged.
- Added a put_work_scheduled flag, checked and set under fl->lock, to
  guard against fastrpc_notify_users() and fastrpc_rpmsg_callback()
  both scheduling put_work for the same context.
- fastrpc_device_release() now drains fl->interrupted and drops the
  invoker's reference on each parked context before releasing its own
  reference on fl, fixing a leak of both fl and the context if the fd
  is closed while a context is still parked.
- fastrpc_device_release()'s and fastrpc_user_free()'s drain loops now
  use list_del_init() instead of list_del(), avoiding a poisoned-node
  list_empty() check in fastrpc_context_free().
- fastrpc_invoke_send() can return -ERESTARTSYS from rpmsg_send()
  itself before the message is ever delivered to the DSP. This is now
  distinguished with a `sent` flag so only a completion-wait
  interruption after a successful send is parked as resumable.
- ctx->args is now repointed at the retry's args on resume instead of
  pointing at the original call's already-freed buffers; an
  args_owned flag lets fastrpc_context_free() free ctx->args if a
  parked context is drained/abandoned without ever being resumed.
- Link to v2: https://lore.kernel.org/all/805d5de8-477c-41e9-b192-d889d1cca9b6@oss.qualcomm.com/

Changes in v2:
- Fix kref imbalance: fastrpc_context_save_interrupted() now drops the
  extra reference taken by fastrpc_invoke_send(), so the worker's put
  correctly reaches 0 and triggers context_free.
- Fix -ETIMEDOUT context leak: remove the ETIMEDOUT exception from the
  bail path so timed-out kernel invocations go through the same
  list_del_init + context_put cleanup as all other error paths.
- Fix dangling node: fastrpc_context_free() now calls list_del_init()
  under fl->lock before releasing resources, preventing a dangling node
  in fl->interrupted if a racing channel removal fires put_wq.
- fastrpc_notify_users() now calls schedule_work(&ctx->put_work) for
  interrupted contexts to drop the worker ref on channel removal.
- Add dev_warn() on TIMEOUT and ERESTARTSYS for post-mortem debugging.
- Use list_del_init() instead of list_del() in the bail path.
- Link to v1: https://lore.kernel.org/all/20260525124222.3082420-1-anandu.e@oss.qualcomm.com/
---
To: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: quic_bkumar@quicinc.com
Cc: quic_chennak@quicinc.com

---
Anandu Krishnan E (3):
      misc: fastrpc: remove dead context drain in fastrpc_user_free()
      misc: fastrpc: drop the DSP-response reference on channel removal
      misc: fastrpc: fix context leak and hang on signal-interrupted invoke

 drivers/misc/fastrpc.c | 187 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 41 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261117-interrupted-invoke-v4-f2e5be78eba8

Best regards,
--  
Anandu Krishnan E <anandu.e@oss.qualcomm.com>

