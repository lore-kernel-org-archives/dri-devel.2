Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63A0D6AB10
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E529C10F64B;
	Thu,  2 Apr 2026 22:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="EC45r/FD";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC72F10F64B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 22:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775167648; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MlJ8hwnnHo/KDrN2J5Nf7vssfFthG5XdbBjwmRJCYpBPn/gDK6EFrpzSDE8QpbNhc/VwpgSDXLpsj/m61w8+h7nCmTdhrLNcRCPD682HVezaLxIgU3hRyk7kj5waflHKnVp+GXTWIq97Je7UnvGYaZP1zGcR9SI+CJuZ9A52A+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775167648;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cMEa7SRLCUREa2uh8r3RWORfmgqlL3NGjKSuIimH92M=; 
 b=EhNYFwkGjxNwbcM4sNEQvnc2jr5PA6O8ga8M92NoEdZR4NHskOgK9dqsf8GRU0NYgWVR8IrZNHx21yoqK7QjJQ29VHEPBWNHNZSvZJ/jcTl8hcOD0V0vzA1ivmEAWO1N6eSk9Mz//Iv7YsqCyWPdrhb9SIjPbpHLT4T8PKWtNuo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775167648; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=cMEa7SRLCUREa2uh8r3RWORfmgqlL3NGjKSuIimH92M=;
 b=EC45r/FDEVHSHRU17hJETwbT+CesTQ5sH2seWl8T3jAQ5+a9iarMrT/uB0VmO7zP
 phXcBwsxPxYn5koKbc7SuviyMMgUQ0h+hvjXcebwIztWv3gFPs3XUzpkVYB6MI3hIoA
 6G6z38B97jQUK/i+En/PJwZsxc7z+WNbNZccZP6k=
Received: by mx.zohomail.com with SMTPS id 177516764656655.417004690233284;
 Thu, 2 Apr 2026 15:07:26 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:07:25 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v3 00/12] drm/tyr: Use register! macro
Message-ID: <ac7onXQLlj_aCc4D@um790>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <CAH5fLghWAQOkH0bDw3vC5UZaCJyXaXn16D_2K8wWOraBcktg3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghWAQOkH0bDw3vC5UZaCJyXaXn16D_2K8wWOraBcktg3A@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 11:58:36AM +0100, Alice Ryhl wrote:
> On Tue, Mar 24, 2026 at 1:18 AM Deborah Brouwer
> <deborah.brouwer@collabora.com> wrote:
> >
> > This series changes the Tyr driver to use the kernel's register! macro
> > for hardware register access, replacing manual bit manipulation and custom
> > register structures with a more type-safe and maintainable approach.
> 
> Please double check the AI review:
> https://sashiko.dev/#/patchset/20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701%40collabora.com
> 
> There are some concerns regarding clock cleanup on patch 3 that seem valid.

Yes, I'm going to just drop patch 3, it opened up more problems than I
expected.

The comments about the 32-bit accesses for the _LO and _HI are valid and
I am fixing them.

The comment about discarding unmapped faults from MmuExceptionType
doesn't seem right because the spec lists the faults exhaustively.
Maybe this comes from comparing panthor's enum "drm_panthor_exception_type"
but those are for more than just MmuExceptionType.

> 
> Alice
