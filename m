Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC3D606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FIpjsxRa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422FD1122AB;
	Thu, 19 Nov 2026 11:18:04 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72B81122AB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:17:57 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4b0a307487aso7764355e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795087076; x=1795691876;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8ezkMimIRdDJVS3UtETrn+MxS3pDa4Eflud97FdBW4Q=;
 b=FIpjsxRabl6KCqCFkxq4Wr31RK55oUREc88fGb0ks9qk1Vt+RnH45zeq6a5Qa6xSZf
 W1paCzQFAGula2kuvsWInI4+Wy9orT56JAjK+B17mboqr9/qeoHVkd1yll9gHDe2W0W8
 c82Nh4vtmxmYugD+q3wbVtaVpEKz7FzTXrEsN3R5w5b2n6/9m+ZKL5GJozooQa09Pf5a
 HmWJJJw/ded0FiLUmyGncMkfexxzxsqrn3mT7Ryc7NABXWXzRqi9SM2MtvaQAod6OOS9
 D6obck3RYqL+esrZAOff+rAwhn7StuahGVD8Acz3MmKGBnTKmGK23FqWQ7tYubJylaAV
 DwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087076; x=1795691876;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ezkMimIRdDJVS3UtETrn+MxS3pDa4Eflud97FdBW4Q=;
 b=H2BBQsKh57Hh1ch61AOUPH1VZQiOnZ1WVAQcILUpgyU8j6oTFHOYbZw+/PZm9jgu8G
 wtyDjkkv6kc2/dU8DbPbcbkdTGR5Et0DCabfgFIyjfMm/YLjtEgV0V4GQVKyXhp1BxCO
 9PDDwpvu1kl14UrSUcGyZiXyfpL8Oyj5+i1m3UQPlmTbDVXpABo8+ro8dwj7tp2VliYm
 yBVBqEiRKLb+UNHheAK1SviBhkP2QGNG9RVwJB5tKZornaC3PohQmaf6WbRP+xdFUVGU
 913eYiuUKzVJIE/YXMKa6ljXQNMeAft7n5ngEO0yBSNQFQKsNUMICH1dERjs585FeNic
 ocEw==
X-Forwarded-Encrypted: i=1;
 AL+hErEtOhDQLnAnbwUqc4UIcpYJDO7rJMKl322yKdIUEFriTDwdko112fZ4jCk/QCFzE2IM0eUpeLUiiV0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/VgMQC7I6oIawkZMsoAisJylWPvVrcKmWFwXLuMOcoEO3bijDP
 NnezLmCiDfbvfAOYF9CU5Lsa+D05NCKbR5s7BlclU1b3tHv0l+CqCHdQx3cRgi9TvbL223R4Nwh
 QzBXp2n7+PVPdP0Vwng==
X-Received: from wmpz13.prod.google.com ([2002:a05:600c:a0d:b0:4b2:3c81:ca])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a07:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4bb7d57770fmr116377775e9.0.1795087075740; 
 Thu, 19 Nov 2026 03:17:55 -0800 (PST)
Date: Thu, 19 Nov 2026 11:17:54 +0000
In-Reply-To: <20261118163203.2483856-8-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118163203.2483856-1-dakr@kernel.org>
 <20261118163203.2483856-8-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119111754.3049805-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 7/7] rust: drm: make Driver::File lifetime-parameterized
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, acourbot@nvidia.com,
 daniel.almeida@collabora.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org, 
 lyude@redhat.com, alvin.sun@linux.dev, deborah.brouwer@collabora.com, 
 laura.nao@collabora.com, beata.michalska@arm.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 05:29:48PM +0100, Danilo Krummrich wrote:

The v3 updates look good to me, thanks!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
