Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F8606A92E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=T/m33FHa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66AA510E0A7;
	Wed,  4 Nov 2026 17:40:44 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B0510E0A7
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793814032; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fyLHYoTLHPy/OmgcjvtH57cttrGPYnFcqkkkMsMb2NglM0pi/lE5+PvFVGb1d9z/Tu0EsThE5tiESq/Br7PFHzMxEef754KM17Krf4kGmj66MzodQQFMw+Q7Udus/3px/vXQmROUtGA/p03rX8OTED5oqv/mx5bXMSKdfM+RejI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793814032;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QKddt74ZqQTluxfuLkY271yIpgW5Ov4BfqlAi2z7wts=; 
 b=FBuccM9SoJ1oCkKiIJEZM0IbSPYCJFeXFf8MTGgmnPqMwLDcUDP3dLZQlR+dG76mxVJ8FZLchY4GtHw4vxraVGj7cPR55P5xKLwXh9D9SHgE169bXlRP78wtvLILeX8JxQ9Q7Y9nStRu01WAQMG5dT2xwQ4lI+aXHdBQtke0XgY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=ashley.smith@collabora.com;
 dmarc=pass header.from=<ashley.smith@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=T/m33FHaKqLFKrONL8rFKQYzrmoVlopvbBS18bhld2i1V+VCTJNFQJ7NZ5Jc4Ukmlv9M/97liHbiXpzR2V34xSD5jF3FpMLT83zBbI/WtWq5eEfbPKCwNgTIlonXzZwY5niReJ74PgfsA6BazegUSIvTtAEn/3zXVuM+M3oxVLY=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=QKddt74ZqQTluxfuLkY271yIpgW5Ov4BfqlAi2z7wts=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793814030702293.8570495916671;
 Wed, 4 Nov 2026 09:40:30 -0800 (PST)
From: Ashley Smith <ashley.smith@collabora.com>
To: lukas.zapolskas@arm.com
Cc: airlied@gmail.com, aliceryhl@google.com, boris.brezillon@collabora.com,
 daniel.almeida@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, nd@arm.com,
 simona@ffwll.ch, steven.price@arm.com, tzimmermann@suse.de,
 Ashley Smith <ashley.smith@collabora.com>
Subject: Re: [PATCH v7 5/8] drm/panthor: Introduce sampling sessions to handle
 userspace clients
Date: Wed,  4 Nov 2026 17:39:01 +0000
Message-ID: <20261104173921.4117593-1-ashley.smith@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 11, 2026 at 06:36:52PM +0100, Lukas Zapolskas wrote:
> +	ret = panthor_perf_bo_get(file, create_args->control_handle, 0, &control);

Like the ringbuffer BO above, I think we need to include the size here since
if the actual size is less than what the kernel expects it could lead to
writing to out of bounds memory (imported BOs):

ret = panthor_perf_bo_get(file, create_args->control_handle, sizeof(
    struct drm_panthor_perf_ringbuf_control), &control);

Could also change panthor_perf_bo_get() to always test and instead
of != use <=

if (obj->size <= PFN_ALIGN(expected_size))

so callers cant silently skip validation.

FWIW, I have tested v7 of this patch series on a Rock5B and can see reliable
counter values.

Tested-by: Ashley Smith <ashley.smith@collabora.com>
