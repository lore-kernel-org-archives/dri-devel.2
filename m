Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2106606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VtzxTUpx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5E210EBF5;
	Mon, 26 Oct 2026 07:41:26 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1A610EBF5
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:41:20 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3ab3b29a210so25093361fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793000479; x=1793605279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h88WcqDPqZBUi5FkapMuvsXDFtP2x22CkYcuFL5W6bs=;
 b=VtzxTUpxy5rPMaNjumxBhBuk5QO2s+bnAFlRmxcN5EbSDqr/2hxdmLVDU4VM83u1vf
 tB0bfFxQTkufbtlt7zfCKnaL3D9GQQ2Q0geFirVeRbNM1tAtxcWNsfyowCEj8wOIG4Vr
 HD1OWxOSdf39QF+f7418bt7d8L5DJ5YlSLnxzUips9d0zYM8LZ4oeVTXTxKK/Btzujl2
 Ag2sowYwHQpdSRucHAUqdt+T4RdRlQNznClYhQ51w2OTXRBISfyOyCNdHxp2f4H+Jtzt
 9WMh6OkafoCCnvKe9mbtfMHV+cuuOuJdH9i8y5WsyKZyTtjku/NAGdv5T54z2/JPgHAY
 CwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793000479; x=1793605279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h88WcqDPqZBUi5FkapMuvsXDFtP2x22CkYcuFL5W6bs=;
 b=cIpEQL7k3upvxIYtXoIwStH8JpayYgDgtQgzvbcnrXWj7j1Jd8IR29uLiTwVTfPU9p
 LpV0l66mB9biqydpQXuB9C9PtrhmyVo5wXGxT8bMqesL96ArUhJL+vv2C3XomT0Vcvdq
 6km639sxPf1WuHhyhPWSnHG9JmuzG/RMvNuVKIh6DP4hmVgvH4OqpLG4DlfJe1KQbV6W
 DfGZW/LAtaMmDMKh/ihkCMq7M0qoiTFv/4wOLPROXLdIAX3EueYoazhRDdz8U5O87Vum
 vFkNg9sg88N+fidJSncgZTrlC687Jw9VI/UMPsOFL3JLmNwed6y9xTaKT48pb3qJxR7D
 /4Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhNFhlqS02GMIG1Vt2aMqtG7Mr+s0Zir5e7ZGX5rqJxGqpAFdHPwlIpuEsKVyohShQPjyx2yL/+BE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLEPrGNZQL1FB/BN7vrRPk+AerLLK6N66bNP6WYHuL8fxqDmSv9
 uSyqrFrcku0wZR10yfxmvRClFXvy7ayin5xXmRJbN2gb1ihHDcalTQJd
X-Gm-Gg: AYBFou3DT7FgF4fP9G5F66//4CHg+oRgR3IPZuNnW3w4GskmznyFA0hM62mqMt8HxHP
 vDhU9HJu4rVr5VCwYAvc+wQHWIgraRPH0YnQpf89nqzRXRcV7gLDppbmDgb9d5ayOD6uujBArnc
 I3DhYkwhA6/tJKVodsAzs0AXETeDzAJT6JA/g2MQPsMkA8CthKcBQ4uZfKdNDkMcmQ6LnaPBLuZ
 do670BbolO5l4PKn5krGqF33dOaxrPZ+Lls9ZZhBljXZCtTUL7QbjyL5XcfI7TmFx5sesIj4cis
 +P4XsmFzBPUxZJWk9dIWiIftwKt0p6mUa0kI3Temy7N0JgXiJbf3d4FjgVvPfNSBXfxPAX0cE/c
 ZUXcHseVTpC1WWpHyjFLwtcMrl5c26O3gMf0Y1uWM+pfAV6cT/zsv0X8tvvw2aePD9R6Oylm7aL
 +AZMByrfMwsph/BTUx5VHSMIkKF9gZPvAOpowmza1xPqPF7SXmZt5AH3acEYFg9DQrMZsCxgA5z
 5fS0hKWktrMh9wPD2MojnGScT7KpRC87JFl397YoaTaGhomxws87p00BtoPkxSOjEiw9UNTlxmn
 O8Uk6l4xn9ofIRlnT0rzl9uAGDX6vmfCxsCm29O+MKCDSSrkMRJ1kQ==
X-Received: by 2002:a2e:a917:0:b0:3a9:8762:d77 with SMTP id
 38308e7fff4ca-3ac6fcbf58bmr12890491fa.6.1793000478642; 
 Mon, 26 Oct 2026 00:41:18 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70a493b6sm15089911fa.37.2026.10.26.00.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 00:41:18 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: set allow_freesync before validating a
 new stream
Date: Mon, 26 Oct 2026 12:41:13 +0500
Message-ID: <20261026074113.299632-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018221726.27259-1-mikhail.v.gavrilov@gmail.com>
References: <20261018221726.27259-1-mikhail.v.gavrilov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Superseded by v2, rebased onto amd-staging-drm-next, where v1 no longer
applies, and with a Tested-by from a second user:

  https://lore.kernel.org/all/20261026073345.297491-1-mikhail.v.gavrilov@gmail.com/

-- 
Thanks,
Mikhail
