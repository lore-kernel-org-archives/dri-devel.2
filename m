Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AC606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=D6i1tabR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C517110E07B;
	Thu, 12 Nov 2026 14:44:09 +0000 (UTC)
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C65A10E07B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1794494555; x=1794753755;
 bh=aq0o03R7e9F2pw69m+iUpHwCBUrNrj8FRpthGHachfU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=D6i1tabRaiEabLSjKLt60DBdRBgc1ghMp/8bV7MeYncwMKpZbKK5AAv1JEBCvN7mG
 NAHVRlu5d231+HRbVexe+koI+ubiZZX1olmurWYZjkLfMZFTmhy0cg9Lg6BeXneYu0
 msslEAx9R23M6rViDj5jTAqogNYMjpgOEeuf7E59esqA6WKnFUP+PFgWIBGdSLBwX2
 hN39xgBJl2xBY6D/eKneQFGvb4LSe5r668ZbM/AW3jEsJrxQWZd84uaCf7LQ5vQbiD
 mJKrsNO4SNSEcrBQjbU/A8RzVipo2I05KdurWxBE8phhDuupBSA7K60VPAwlfn/SJV
 apHpNx4EsqQQg==
X-Pm-Submission-Id: 4jQNQc4KLdz2Scmw
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v7 0/3] drm/tyr: GPU reset infrastructure
Date: Thu, 12 Nov 2026 17:42:27 +0300
Message-ID: <20261112144231.279851-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <AE29D511-8F4A-49A3-BE4E-31E6411816D7@collabora.com>
References: <20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev>
 <70AFEE33-C637-4D49-88F1-9DF3A9BBF097@collabora.com>
 <20261111100745.3929894-1-work@onurozkan.dev>
 <AE29D511-8F4A-49A3-BE4E-31E6411816D7@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 12:33:47 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> Hi Onur,=0D
> =0D
> > =0D
> > Any updates on this? I am preparing v2 of the GPU unplug series [1] whi=
ch=0D
> > depends on this series. The reset patches need rebasing against current=
=0D
> > drm-rust-next.=0D
> > =0D
> > Would you prefer me to send a rebased v8 and base unplug v2 on it or ar=
e=0D
> > you planning to pick up v7 and handle the rebase?=0D
> > =0D
> > Thanks,=0D
> > Onur=0D
> > =0D
> > [1]: https://lore.kernel.org/all/20260823-tyr-gpu-unplug-b4-v1-0-e99c07=
d4c785@onurozkan.dev=0D
> > =0D
> =0D
> I'm only waiting Alice's R-b before bringing this in. Feel free to send a=
=0D
> rebased version, since it will probably be needed for the unplug work too=
.=0D
> =0D
> -- Daniel=0D
=0D
Okay, I will.=0D
=0D
Thanks,=0D
Onur=0D
