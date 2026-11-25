Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0C606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F9fQEbk3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=daaCHOG3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0980E10E3AA;
	Wed, 25 Nov 2026 00:07:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EF610E3AA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMasaw2287992
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YCNZoUZm4GBeMsriz4yFo0wE9eJVtGfqSHsFxrSTkGw=; b=F9fQEbk3KbG3tw1Q
 5XBc22fQP0YyyDnUmuVn4NzHCKmt2loxjKqi7l+X5T2y7kMZeI/hy1z48HeBfI2X
 ru4cwnAheuGQz1tmTXXhQyyT4NvhsBOpZjPJk2I+NTV07Rz2xOCKNvP9gLvh/S1E
 dQ+F5hqasXiGDWUsJ79Ekw/FBv68lv7Yb0YVerSMt0eHDH4N4Tv+7VEss9Hckv9W
 WW0i06bUDzF9OdyM5kXEOcZwEzVbN/aPXMAjbzRo18YTqtiIJNYqxKWflm/lcKLx
 6Kx1QfD40n7x3uy9pdu9jKnfB9T4uo6tRd8QUopxqnqX3r/ck2FUVPMnwCYU1QLz
 sjze/g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egs9h91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:07:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so8047800eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795565225; x=1796170025;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YCNZoUZm4GBeMsriz4yFo0wE9eJVtGfqSHsFxrSTkGw=;
 b=daaCHOG3CKGechNL3Korb8g4blTm/dBbKilaPuULyMFhnrtPCcVJDa2qgFbN1TtlLR
 Hpmpvx1K9tK/fF+AiBkt4YiaxJswS8vLa+7NKnlA9aoHfbpjkhwJ+wpJWagLmN14HKfL
 vckFEB6oRuIIu7qI4Z9wKJWElI4nEoMLBF+cT1w+Sy0XRJ9/MQENDK68g9FU246jWD2r
 gWmm7mgQtxp7ca+4qpTJOP3+9q7C9AAKdYfciv+BAaBxE9JNpVbFwifrN3utr1OTf9D0
 9VCR2H1QF5qcEdXmg+sW6zPjARmBlmG85Ka/8Aazc8SYKA4DAe7F6xhRh799rQ6Xp2RA
 7lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795565225; x=1796170025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YCNZoUZm4GBeMsriz4yFo0wE9eJVtGfqSHsFxrSTkGw=;
 b=bqwXoByhxaH1w7Lz6ZjCzq4/GMd8yTMZ42Pk/i3wEr1lFr00+kmJfnbz+EO1lCwmg9
 iZQaLoUdK00PWnIX362ijwB8glF29vZbXxNVEqdOsn3KsAnwkgUAtDoZBL/i82yMnDNV
 vChVIeISnI8o5ndvEs2sTqVNl3lBLjt+xSsRHSUuHyDEu7geaJr5ElwuvZDq0ha5/+Az
 U6rc9BPl+dCAU5AG5WRgCWc1weSTvkyFtSHMSy4Mi9qebMwFi2+riv3HDhlgAQ5P3qQX
 dR1gUwcwjE4NaPhX1o6Ykg53Itknn8gvZb757kaOT8RhWx5kbgHYdyIg+zXSYAi3/dTU
 3veA==
X-Forwarded-Encrypted: i=1;
 AL+hErHjwDxTcKP78xVKrL6kvMJlgS2jJLhPHoCpRe8vtcEO+RmHGWWUhWf003hGTsh23KvdTHrBs/SnpHE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8bKAaKOXC87FY62F9iIQDeCLcJ4GEpNa/j0MMjLKAy1L8k5sgz
 u7KxeowiUufUDc0JtyE4fn1vu6PUWqW6nhdx0d3ECIYWgbqOiCJUwRwCh6GMbjQFPbEMb5YJ7yY
 QTCmA9yLg++Rsh5cZyUcGkA4U964QJgBBxIO3pbhLw7slnZvuWV9xIOCZePBA7rdEZmbY4B0=
X-Gm-Gg: AZFdTZcjm5TpXtes6Dmh7Hn/kkFTut/JQrB6AsPdfTVwmVOAjzTDsx0HOa9VvC9QcUi
 lZPA7NNVT4nTImnWS4I7XAAq7TTAeWgGDyvMbg/n5zdW7RMiUa8uClQ+KlludnCETr3CT0cie2X
 OhfmRxw1Ml8tyLgU5m38RTv/fabO6Cp811HRR/xhZXRzGXVRXnWAfgIpfEc2mPTXtEkkTMTdpPc
 nz9fCBwenx3WaWITnHrfjpcZceGaGMdS+2+bImnm+IMK1aJ5DIRzUKrz81oFOx7ItIVO7Ensl6M
 ZrwlqabaGEOsmpR68K2MaHD9LEBx6nVmMvQh/FATAJrZHytKeD9CfFr8r0koEtlUoEmFHMbJ1uR
 GNdURBawJglr5ZAzZDLfOQ8SZIFkaMGh9K1y1o0GG8TqF6vKs4dx7c4fBYQ==
X-Received: by 2002:a05:7301:1402:b0:375:ed63:5f12 with SMTP id
 5a478bee46e88-3856fe564admr18926360eec.22.1795565224326; 
 Tue, 24 Nov 2026 16:07:04 -0800 (PST)
X-Received: by 2002:a05:7301:1402:b0:375:ed63:5f12 with SMTP id
 5a478bee46e88-3856fe564admr18926303eec.22.1795565223569; 
 Tue, 24 Nov 2026 16:07:03 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c371esm47494708eec.23.2026.11.24.16.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 16:07:03 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 05:36:43 +0530
Subject: [PATCH 3/4] misc: fastrpc: query the dsp capabilities during probe
 time
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-fastrpc-hpass-support-v1-3-cb1d46b29e3b@oss.qualcomm.com>
References: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
In-Reply-To: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com, dmitry.baryshkov@oss.qualcomm.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfX/Rq8RmA2Gu+d
 zkgqVhMNi/F131FNiNWLyS2a/st2stP0/cJz/UrJQzQ1jtxVQR3uhXCRVIOuog0/qmVYMcuYChH
 0L6YgSyZoJnINUQTeFCtZgxkLjuFKvSMHwTCeXNgSiloKGQzGSAvFTTML1ALerjA712Ga8tz8dS
 mOogtH099s9b/yovIVr1HnTNnSnkGMIrrNG+wtnJHcefzfiJcpvH9UD5yvccIN66bzw/IgHJV8/
 6BuksMOqfAXz5awWDHKLj1Bo6nogA4EFPB+4tfG3Aspt25uz1IQPPIeEMi4h5egpWgYCy9dd91b
 BWe6+1SBNMTxMeSCJy+GaqLAiFoojtctQAdvyMJtlYFJjGgE9g2KpVvgwWo0G/ZEARMzUMKy4/s
 sL1B8IDPt8pCLBDDAwsUbdPSYd8mw73sHkHD/SxM2mhjTX5CbxrJnTjkmNkJ9h8QbwSKwBSSSge
 0nyG+FCpo/yIITQIh/g==
X-Proofpoint-GUID: x_PpRqELOMh5SUp-o7ovGcGHrojvLwsX
X-Proofpoint-ORIG-GUID: x_PpRqELOMh5SUp-o7ovGcGHrojvLwsX
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b0626a9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jtXnty-gg5gQuGKUqicA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwMCBTYWx0ZWRfXwE2+Bqvt10eZ
 Mn+Ikom113/iObQ3HEZucSciwr/72ce5WePfOT54QzweJJkImGBc9y2vYrAYE+3DWAAqXCdfQV4
 8lFD39oL1/BJJLXkivcg9N/eAeT7PUE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250000
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

An HPASS domain can load either an audio firmware image or a compute
firmware image, and only a compute image exposes an unsigned PD node
in addition to the signed one. Which image is loaded is only knowable
by querying the DSP's capability attributes, and the driver needs
that answer before it can decide which /dev/fastrpc-* device nodes to
create. Today the query happens lazily on the first
FASTRPC_IOCTL_GET_DSP_INFO call from userspace, well after the device
nodes have already been created from the domain id alone.

Move the query to probe time, before the device nodes are registered,
so the set of nodes created reflects the DSP's actual capabilities.

A synchronous query in fastrpc_rpmsg_probe() would work but
fastrpc_internal_invoke() can block for up to 10 seconds waiting on
the DSP, and a target can have several DSP domains probing
concurrently, so a single slow or silent domain would delay bring-up
of the rest. Instead, run the query on a per-channel high-priority
ordered workqueue (WQ_HIGHPRI | WQ_MEM_RECLAIM) so that probe()
returns immediately, and register the device nodes from that work
item once the query completes or times out.

fastrpc_rpmsg_remove() cancels the pending work and destroys the
per-channel workqueue before tearing down the rest of the channel
state. The temporary client used to drive the query is linked into
cctx->users for the duration of the invoke so that a concurrent
channel removal aborts it via fastrpc_notify_users() instead of
blocking on the full invoke timeout.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 225 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 177 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c515097c3d3b..59ef755feeaf 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -338,6 +338,10 @@ struct fastrpc_channel_ctx {
 	atomic_t ctx_seq;
 	u64 dma_mask;
 	const struct fastrpc_soc_data *soc_data;
+	/* Per-channel workqueue for the probe-time DSP capability query */
+	struct workqueue_struct *cap_wq;
+	struct work_struct cap_query_work;
+	char domain[8];
 };
 
 struct fastrpc_device {
@@ -2704,6 +2708,159 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 				  cctx->vmperms, cctx->vmcount);
 }
 
+static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
+				    struct rpmsg_device *rpdev)
+{
+	struct device *rdev = &rpdev->dev;
+	int err, i;
+
+	switch (cctx->domain_id) {
+	case ADSP_DOMAIN_ID:
+	case MDSP_DOMAIN_ID:
+	case SDSP_DOMAIN_ID:
+	case HPASS_DOMAIN_ID:
+		cctx->unsigned_support = false;
+		err = fastrpc_device_register(rdev, cctx, cctx->secure, cctx->domain);
+		if (err)
+			goto err_depopulate;
+		break;
+	case CDSP_DOMAIN_ID:
+	case GDSP_DOMAIN_ID:
+		cctx->unsigned_support = true;
+		err = fastrpc_device_register(rdev, cctx, true, cctx->domain);
+		if (err)
+			goto err_depopulate;
+		err = fastrpc_device_register(rdev, cctx, false, cctx->domain);
+		if (err) {
+			misc_deregister(&cctx->secure_fdevice->miscdev);
+			cctx->secure_fdevice = NULL;
+			goto err_depopulate;
+		}
+		break;
+	default:
+		err = -EINVAL;
+		goto err_depopulate;
+	}
+
+	/* Duplicate the last session so multiple processes can share
+	 * the same compute bank.
+	 */
+	if (cctx->domain_id == ADSP_DOMAIN_ID && cctx->sesscount > 0) {
+		struct fastrpc_session_ctx *last_sess;
+		struct fastrpc_session_ctx *dup_sess;
+		unsigned long flags;
+
+		spin_lock_irqsave(&cctx->lock, flags);
+		last_sess = &cctx->session[cctx->sesscount - 1];
+		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
+			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
+				break;
+			dup_sess = &cctx->session[cctx->sesscount++];
+			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
+		}
+		spin_unlock_irqrestore(&cctx->lock, flags);
+	}
+
+	return 0;
+
+err_depopulate:
+	fastrpc_cb_devices_destroy(rpdev);
+	return err;
+}
+
+static void fastrpc_cap_query_work(struct work_struct *work)
+{
+	struct fastrpc_channel_ctx *cctx =
+		container_of(work, struct fastrpc_channel_ctx, cap_query_work);
+	struct rpmsg_device *rpdev = cctx->rpdev;
+	struct device *rdev = &rpdev->dev;
+	u32 *dsp_attributes;
+	struct fastrpc_user *fl;
+	unsigned long flags;
+	int err;
+
+	fl = kzalloc_obj(*fl);
+	if (!fl)
+		goto register_devices;
+
+	spin_lock_init(&fl->lock);
+	mutex_init(&fl->mutex);
+	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->maps);
+	INIT_LIST_HEAD(&fl->mmaps);
+	INIT_LIST_HEAD(&fl->user);
+	fl->cctx = cctx;
+	fl->pd = ROOT_PD;
+	kref_init(&fl->refcount);
+	fastrpc_channel_ctx_get(cctx);
+
+	fl->sctx = fastrpc_session_alloc(fl);
+	if (!fl->sctx) {
+		dev_warn(rdev, "no session for capability query, skipping\n");
+		fastrpc_user_put(fl);
+		goto register_devices;
+	}
+
+	dsp_attributes = kzalloc_objs(*dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
+	if (!dsp_attributes)
+		goto err_cleanup_register;
+
+	/* Linked into cctx->users so fastrpc_rpmsg_remove() can abort us
+	 * via fastrpc_notify_users() instead of waiting out the timeout.
+	 */
+	spin_lock_irqsave(&cctx->lock, flags);
+	if (!cctx->rpdev) {
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		goto err_cleanup_noreg;
+	}
+	list_add_tail(&fl->user, &cctx->users);
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	list_del(&fl->user);
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	if (err == -EPIPE) {
+		/* Channel is going away; remove() will tear it down. */
+		goto err_cleanup_noreg;
+	}
+
+	if (!err) {
+		spin_lock_irqsave(&cctx->lock, flags);
+		memcpy(cctx->dsp_attributes, dsp_attributes,
+		       FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
+		cctx->valid_attributes = true;
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		dev_dbg(rdev, "DSP capabilities cached at probe time\n");
+	} else if (err == DSP_UNSUPPORTED_API) {
+		dev_info(rdev, "DSP does not support capability query\n");
+	} else {
+		dev_warn(rdev,
+			 "probe-time capability query failed (%d), will retry on demand\n",
+			 err);
+	}
+
+err_cleanup_register:
+	kfree(dsp_attributes);
+	fastrpc_session_free(cctx, fl->sctx);
+	fl->sctx = NULL;
+	fastrpc_user_put(fl);
+	goto register_devices;
+
+err_cleanup_noreg:
+	kfree(dsp_attributes);
+	fastrpc_session_free(cctx, fl->sctx);
+	fl->sctx = NULL;
+	fastrpc_user_put(fl);
+	return;
+
+register_devices:
+	if (fastrpc_register_devices(cctx, rpdev))
+		dev_err(rdev, "failed to register device nodes\n");
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2761,34 +2918,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->poll_mode_supported = soc_data->poll_mode_supported ||
 		of_machine_get_match(fastrpc_poll_supported_machines);
 
-	switch (domain_id) {
-	case ADSP_DOMAIN_ID:
-	case MDSP_DOMAIN_ID:
-	case SDSP_DOMAIN_ID:
-	case HPASS_DOMAIN_ID:
-		/* Unsigned PD offloading is only supported on CDSP and GDSP */
-		data->unsigned_support = false;
-		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
-		if (err)
-			goto err_unmap_heap;
-		break;
-	case CDSP_DOMAIN_ID:
-	case GDSP_DOMAIN_ID:
-		data->unsigned_support = true;
-		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
-		err = fastrpc_device_register(rdev, data, true, domain);
-		if (err)
-			goto err_unmap_heap;
-
-		err = fastrpc_device_register(rdev, data, false, domain);
-		if (err)
-			goto err_deregister_fdev;
-		break;
-	default:
-		err = -EINVAL;
-		goto err_unmap_heap;
-	}
-
 	kref_init(&data->refcount);
 	atomic_set(&data->ctx_seq, 0);
 
@@ -2804,31 +2933,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	err = fastrpc_cb_devices_create(rpdev);
 	if (err)
-		goto err_deregister_fdev;
-
-	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
-		struct fastrpc_session_ctx *last_sess;
-		struct fastrpc_session_ctx *dup_sess;
-		unsigned long flags;
+		goto err_unmap_heap;
 
-		spin_lock_irqsave(&data->lock, flags);
-		last_sess = &data->session[data->sesscount - 1];
-		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
-			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
-				break;
-			dup_sess = &data->session[data->sesscount++];
-			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
-		}
-		spin_unlock_irqrestore(&data->lock, flags);
+	/* Probe returns immediately; the capability query and device node
+	 * registration happen asynchronously on this channel's own queue.
+	 */
+	data->cap_wq = alloc_ordered_workqueue("fastrpc_cap_wq_%s",
+					       WQ_HIGHPRI | WQ_MEM_RECLAIM,
+					       domain);
+	if (!data->cap_wq) {
+		err = -ENOMEM;
+		goto err_destroy_cb_devices;
 	}
 
+	strscpy(data->domain, domain, sizeof(data->domain));
+	INIT_WORK(&data->cap_query_work, fastrpc_cap_query_work);
+	queue_work(data->cap_wq, &data->cap_query_work);
+
 	return 0;
 
-err_deregister_fdev:
-	if (data->fdevice)
-		misc_deregister(&data->fdevice->miscdev);
-	if (data->secure_fdevice)
-		misc_deregister(&data->secure_fdevice->miscdev);
+err_destroy_cb_devices:
+	fastrpc_cb_devices_destroy(rpdev);
 
 err_unmap_heap:
 	fastrpc_remote_heap_release(data, rpdev);
@@ -2864,6 +2989,10 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
+	/* Wait for a pending capability query before tearing down cctx. */
+	cancel_work_sync(&cctx->cap_query_work);
+	destroy_workqueue(cctx->cap_wq);
+
 	if (cctx->fdevice)
 		misc_deregister(&cctx->fdevice->miscdev);
 

-- 
2.34.1

