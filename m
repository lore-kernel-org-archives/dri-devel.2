Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16A606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=BZkw0AtN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2B410FC3E;
	Wed, 18 Nov 2026 13:08:22 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CCF10FC3E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795007290; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ufjs4Lh67ToZNkP0KJ/D+MIaXlpdBfx7QRjmlCf7Q3qcmV/pAxCtIOCGGv4/+5owJnYqEH3HArH9clTtjMZsA9v4qKrTi/BIcTF6iBD32T5kVIIhaFXOI8FhHeWm5Sge9Lsaw52mfqDgzJS+zDdoYTsNy8ig2gFOWUiWu5+ZXhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795007290;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NJ7T0AiMRWiQis79R0RdVxGbgysmk1qBN7xbr3bMyWQ=; 
 b=TWIDctKK8qVRDeG6Z+0qXzq+KUFd14AjINf4uMBQ7J9qLO8dyAZAWdjgStL26yLGu2bJejHUdAu6dN0iM9YuODd0CwRP2eSQ59Jy+kdiGNzf+41ouPUxYQ2uyB0StPEYj22DlA48JGxFlIrf5/lbKGk7H2Z+B/xu7y1QjEcj0IY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=BZkw0AtNDJav65XEcFiBMFwRKKLpcPoAZPj/o0DoVSFyrqNtQsgXo0jkOtXd8jpPTfPGEV+PAIV9ksK9Ko/VIcYabeqPG8+h6Q407hR1r/KhHHVTy2dJzpESVIr+z1HR6sp1ogMvIt5EeG2qcOmEJO2ad34mEecCk2yNCTmOsXA=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=NJ7T0AiMRWiQis79R0RdVxGbgysmk1qBN7xbr3bMyWQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795007286787165.91293514992333; 
 Wed, 18 Nov 2026 05:08:06 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v8 1/3] drm/tyr: clear stale IRQ state before soft reset
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <av2U1FflKT1mEotg@google.com>
Date: Wed, 18 Nov 2026 10:07:49 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, boris.brezillon@collabora.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B56A0B7A-A0DC-4BCC-8556-F7BC105B991F@collabora.com>
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
 <av2U1FflKT1mEotg@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 18 Nov 2026, at 09:06, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Fri, Nov 13, 2026 at 05:32:26PM +0300, Onur =C3=96zkan wrote:
>> Previous reset may leave the reset completed IRQ set which can make =
the
>> poll return too early.
>>=20
>> Clear the IRQ first so the driver waits for the current reset to
>> complete.
>>=20
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>=20
> Do you want me to merge this now, without waiting for the other =
patches?
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

If Onur is fine with this, I think we should merge what we can.

=E2=80=94 Daniel=
