Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5654606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=g+gmFSjz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B06112185;
	Thu, 19 Nov 2026 08:36:56 +0000 (UTC)
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch
 [109.224.244.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A89112185
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795077404; x=1795336604;
 bh=OPP1MieS0VNVBINP7zSop94t49ytQI32gCfZ4Nx3mpU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=g+gmFSjze5ZdnsEgVQIiE5jHA1Crp4ZVTj90p4WNknjXVjMcM+w4Z/KjwSUF2ZQdN
 wuUXaDt4EqDpeCkV/GK2YlufFHTeeFf+Jj3RyQQMYcAbDLjRoklo+iUUy+3LzsOkw0
 +bEZBrdINk9WSqetgwAkisC7992CiBTyeD7u/tqRk5j1VVBmA1iapxwELLDXkf+nj7
 kzd2RKXY8VwodNX7qyBVcE76Hb0aLg4KmePBpl077/MnBZo0DAuJO/cNmAI+aBt+h6
 ReN6HNGFpohHJrVJAN2Fjvhks5CyhoRZuuN3RkivUyIifNAxKzJzehErfLG1bqVfEp
 5quFNPF1ao6Ew==
Date: Thu, 19 Nov 2026 08:36:40 +0000
To: Mario Limonciello <superm1@kernel.org>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Richard Hughes <richard@hughsie.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>, simonit.orig@gmail.com
Subject: Re: [PATCH v4] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Message-ID: <oUnLboT5nQrS84FGA16aamWt5D9VXEosZZdV3BIUQ1cu4drCXXKDR3kPP0vGvglmf0jXGMvoaYLI1jYamvaz4Zdd2D-6BJ-7I9bv3eZylm4=@protonmail.com>
In-Reply-To: <20261118-superm1-amdgpu-ddc-v4-1-539eaeb4edd7@kernel.org>
References: <20261118-superm1-amdgpu-ddc-v4-1-539eaeb4edd7@kernel.org>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 052ffb8e4a2627105944cf75376cb3f46a5557dd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mario,

Thanks for folding it in and for the credit. My part was written with
help from an AI assistant, so per Documentation/process/coding-assistants.r=
st
as far as I understand, the commit should also carry:

Assisted-by: Claude:claude-opus-5-5

Could you add it when this gets applied?

Thanks,
Eren

