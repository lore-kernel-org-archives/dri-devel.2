Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734F8C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A32F10E5BA;
	Thu, 10 Sep 2026 08:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WrXn+bLJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C76710E5BA
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:07:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76C36600C8;
 Thu, 10 Sep 2026 08:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B3F1F000FF;
 Thu, 10 Sep 2026 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789027633;
 bh=wu44bqMpJmRzCSry4BwDWczEoValyFTrulWWeh+o0MI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WrXn+bLJNYT2CHcp1zs1zy6pJlQaDA1NiAOvGNrJnQz9iZR/IorKOfwhRfHI0kQMs
 ERd7qd7GBERf+wjop2NAXD1mWowdb8ObSrOcbvQGJaHB3ypatfbC/ZyUP09mpPIInQ
 Yutgp2016mEhA2tFNUqNp9qtnnBfj0lzggQikrfDvoM8VF85vYQ9c4PWyXakbZHHOh
 6zvhba0r8rkgKarDVXRWnUGm3oB6kfBmREARpuPPV/TN2h3EsPCe1ZUbAdEtv99Jsk
 cFoqYEKRBOik85j6yJJvs0O0Ok0eEk8aFpU8iIYSmBz+hDIjy4jMM+6Gb0aEc6qoLC
 L1fONFqMPBSxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/imagination: Avoid initialisation of unused FW
 trace buffer pointer
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-2-7e10274384c2@imgtec.com>
References: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com>
 <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-2-7e10274384c2@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 08:07:12 +0000
Message-Id: <20260910080712.F3B3F1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the debugfs trac=
e output formatter uses unbounded `%s` to print firmware-provided assertion=
 strings, which can read past the end of the allocation if the strings lack=
 a NUL terminator.
--

commit 97d5534fd4f9139da050fa97ad4093d575e6bdd3
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Avoid initialisation of unused FW trace buffer pointer

This commit removes the initialization of tracebuf_space->trace_buffer,
an unused pointer in the firmware interface structure. The trace buffer
source pointer continues to be used as before.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm=
/imagination/pvr_fw_trace.c
> index 6bb5baa6c41b7..813b7b0c8d4e9 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
> @@ -101,7 +101,6 @@ tracebuf_ctrl_init(void *cpu_ptr, void *priv)
>  		pvr_fw_object_get_fw_addr(trace_buffer->buf_obj,
>  					  &tracebuf_space->trace_buffer_fw_addr);
> =20
> -		tracebuf_space->trace_buffer =3D trace_buffer->buf;
>  		tracebuf_space->trace_pointer =3D 0;
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at another part of
pvr_fw_trace.c in fw_trace_seq_show(), the debugfs trace output formatter u=
ses
unbounded %s format specifiers to print firmware-provided assertion strings:

    seq_printf(s, "ASSERTION %s failed at %s:%u",
               trace_seq_data->assert_buf.info,
               trace_seq_data->assert_buf.path,
               trace_seq_data->assert_buf.line_num);

Can this read past the end of the allocation if the firmware provides strin=
gs
without a NUL terminator?

Since assert_buf is the last member of trace_seq_data, reading past the end=
 of
info or path could read out of the structure's bounds into adjacent heap me=
mory.
If the unbounded string read crosses a page boundary into an unmapped page,=
 it
could cause a kernel panic. Additionally, it might leak adjacent kernel heap
memory into the debugfs output.

Would it be safer to use %.*s with the maximum buffer size, or forcefully
NUL-terminate the buffers after copying them from the firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-b4-avoid-i=
nit-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com?part=3D2
