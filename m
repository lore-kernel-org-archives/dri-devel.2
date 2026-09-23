Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC95C98328
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40DF10F90D;
	Fri, 25 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="AJIfUjnp";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C94A10E83E;
 Wed, 23 Sep 2026 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=1H+3Z2DPAcCWqo1xbpVn92Me3B62Xb28l4NormQ35o8=; b=AJIfUjnpVEyRUeft6V8FsjDZ/h
 29+o65vm2jRXPCZM5PiAT9NkquWaTUdyi9+DrjRskOXLNPTud3tFAn47TOpMRTtO69hTWb8l3QYgl
 cHML4WqWCVW3qFoiljy9ZnKCBftMXJAZ9UWNsjif90oExj5wkBoGoMA7dfyX0HQxHdCd0Ll2Y+L12
 fgtUsHI8L6MRptIAml6YpIZAs0LIHLjPu1pjwDiM7BQnWMDLNTurDkoFDm3DcDPM91xA99Kc8EQqK
 YSfHEvIaifZ299vA37Qm5yGb0Rl2EvXiMYdhExrGa3s2sAZJ2uqMJEiEz0Jh5+g6x+pviFvYz7cia
 BfzCsyHg==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <leitao@debian.org>) id 1x9Jah-003fMW-2s;
 Wed, 23 Sep 2026 09:48:40 +0000
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/6] configfs: Allow the registration of const struct
 configfs_attribute
Date: Wed, 23 Sep 2026 02:48:06 -0700
Message-ID: <179015667258.1932464.18085260511355627713.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Debian-User: leitao
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Thu, 16 Jul 2026 19:09:25 +0200, Thomas Weißschuh wrote:
> The attribute structure defined in driver code never need to be
> modified. Allow them to be marked as const.

Applied, thanks!

[1/6] rust: configfs: remove mutability from some field initializers
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=fd2d4fa740e2
[2/6] configfs: Constify is_visible/is_visible_bin in configfs_group_operations
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=8ea6cd50ce94
[3/6] configfs: Treat attribute structures as const internally
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=9c21b22db69e
[4/6] configfs: Constify configfs_bin_attribute
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=a84dbcbac28a
[5/6] configfs: Allow the registration of const struct configfs_attribute
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=8900c54dc695
[6/6] samples: configfs: constify the configfs_attribute structures
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=620938e7da89

Best regards,
-- 
Breno Leitao <leitao@debian.org>
