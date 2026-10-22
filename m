Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CD1606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g1vizFPD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11711129C4;
	Fri, 23 Oct 2026 07:28:40 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FAE11275A
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:37:19 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-15943c9c005so2354811c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792683439; x=1793288239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WT2TOXMwrCOf5xSTdDSPXtJnpx/lq+nJmOy+mLlD8TI=;
 b=g1vizFPDYX2Oo6c78eTeZElM/fYiKMhcdhYODWtipyzJqYN2eEA2k2kw+6OJK5ofjT
 PWlkVyUu7qTyuWj7Car5ZSdtj3RQATQ2cWwcrCi8JlZzH2Dc4E+o5UUMQRcXRQYAbng4
 AkAAn/oTmR6P6oyGJcF99ngZGkA4sp0NhU48gYdfqYfz7dt9rtuLQPxYRMGHstvTKFz/
 AQqW8SRDhCPJZ5prb81oHY9erWFETlDlK+PZmSdJmF52BYaXKbooau3xq7rPHgTahSJW
 ae4+FvjE24Z0VqDv83dCkQ1PD5JtJDIwljjIQT6mbqYjJXc0GeqiY17k+Ol4J2S3WfOn
 Ua3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792683439; x=1793288239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WT2TOXMwrCOf5xSTdDSPXtJnpx/lq+nJmOy+mLlD8TI=;
 b=0/K+IVMsuDSLNZXdnfIHDMNHcv26gvrSLCKi5eOiGEmnSNHuIFh51BVeBnM8Tmx9Dx
 ohcp63tfrbGyWfF/Xzs0a2qiCp88OfpKODMoyOzyd1Rqs4Uavta1hrH+KKHen/6fADld
 uzblLvKW9hfqTNh3eOUcj+c9tnOZJt7ofQ0VePXkcRAlNO+owg3ogQ0aD7ky+o9VGv0v
 ufgjkEvmJ9aWcIehwqyQ7o5C/JWncs8wBmhD9UD6iOoAeHAK1rx6M2Sl1BH2ymODwFVy
 yei2aJ25qv18oXNuAj9Vd7qO6bu0aPCyjAytoqMx/qRYj6X+mWzcxrXljy+bbGCn9T8K
 IA2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxT6XMe6o4wCp+RupawUMTPwtxpZewfEvBrXk+VQ+0ZX9uwBoYd1qbDh66awo7OZw6BaoKdnTfr9ag=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8yqPcqFV7p17lPWNsjrtVfz4PAVrBQTUxQFNANlmHEbtpf8M5
 2E/1FmvJtXzfpVnc1WUPU57XV8+n2bn2u0iSThV35P1oef6DHrMw4IHA
X-Gm-Gg: AYBFou2k5EkeMR/SDS6vSHjQuE6mgcgWu2HRYV85gtVq/Y0EpgIghy0t93t0Md5eQBy
 WHpp/arTstcqsf8jApHmfHLYIsyrT7WDNYtfUyyTUWFe524HxfjXEe/3+WFa9newlugBcDGamrK
 FBc+TgaGJe9K4G1m3fQuz9wJdaqDZBsV66sk9b2UU9c959bcICu5JZ1J3LG6G5pSpE2z9ji+3C4
 hGAKtiaoDskFdMIKqafSsKYSdCO4DPHPQlVxgLbCo2Hfx2VEbcZD2uNSo4C+2cevIpbNiEuAwFd
 al7MSzPkwRSoXmT4fOj16+lnPD2Nxnwqjo1YC2bBInCZjGK/DidoWvw0mDMLpTotXFWZXSLX3O4
 MrC+aC9JbzkuC8r/gzN0L8wL3HxVfdWArZYjrHJzNmbPdz1pd2hY69E4nEryuPiOyM+aCTeFwNY
 fI+L3/nFlkFWL3L7rlB6Q+f95WTfquZFEfsy6st7S1xV590fAK+7kQWatz5tPp4sbGYdGErPvRu
 4OzP0c4escUNnA/ngkwADN5Y0NRJ8RGWHgZ7jKvk5gBnGHGBHsytClYtz/fApnjRb7XrMXAg+by
 34I=
X-Received: by 2002:a05:701b:2616:b0:182:2feb:a170 with SMTP id
 a92af1059eb24-190a6adcb12mr6334470c88.11.1792683438586; 
 Thu, 22 Oct 2026 08:37:18 -0700 (PDT)
Received: from kush-pc ([106.213.87.38]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bf5d0a1sm15780435c88.14.2026.10.22.08.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 08:37:17 -0700 (PDT)
From: Kush Chandak <kushc451@gmail.com>
To: Risto Pajula <or.pajula@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/nouveau: fix GK107 VDPAU regressions
Date: Thu, 22 Oct 2026 21:07:12 +0530
Message-ID: <20261022153712.11208-1-kushc451@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913201225.5975-1-or.pajula@gmail.com>
References: <20260913201225.5975-1-or.pajula@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:28:18 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 13 Sep 2026 23:12:23 +0300, Risto Pajula wrote:
> This series fixes two independent Nouveau regressions affecting VDPAU
> hardware video decoding on NVIDIA GK107 (Kepler).

I ran into both regressions on a GK208B (GeForce GT 710, NV106) with
VA-API and arrived at the same two fixes. Built against the same nouveau
source, my versions and this series give identical machine code for
gk104.o and uchan.o.

Tested on Ubuntu 26.04 (kernel 7.0.0-38) with the two changes applied
to nouveau, video firmware extracted from NVIDIA 340.108, Mesa 26.0.8
with the VA-API fixes from Mesa MR !45340, and ffmpeg -hwaccel vaapi:

  H.264 1920x1080:  600/600 frames identical to software decoding, 115 fps
  MPEG-2 1920x1080: 300 frames, 164 fps
  no nouveau messages in dmesg

Without patch 1, MSVLD faults with PRIV_VIOLATION on the first frame
and the channel is killed. With only patch 1, decoding blocks for 30 s
in DRM_IOCTL_NOUVEAU_GEM_CPU_PREP and then fails with -EBUSY.

Patch 2 also fixes an out-of-bounds access. Without nonstall_ctor,
nvkm_fifo_oneinit() creates the non-stall event with a single index,
so event->refs[] has one entry, but nvkm_event_get()/nvkm_event_put()
are called with index runl->id and don't check it against index_nr.
The Kepler video engines are on non-zero runlists, so their channels'
non-stall events increment and decrement memory past the end of
refs[].

Both regressions are in stable kernels (since 6.2 and 6.6), so it may
be worth adding

  Cc: stable@vger.kernel.org

to both patches.

Tested-by: Kush Chandak <kushc451@gmail.com>

I used an AI assistant (Claude) to help debug and test this.
