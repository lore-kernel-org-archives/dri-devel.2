Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D3606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jcGFSo3n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FF910EBD8;
	Mon,  2 Nov 2026 08:04:12 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C5C10E032
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:31:55 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1176044f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793575914; cv=none;
 d=google.com; s=arc-20260327;
 b=KfLZVyiXruREZlPFD0MowSuREDggsXklGfBZgEqrzhoPXYSqhre8/O8I0PjOx/rjIO
 387o1eQ6d3xV8OOTxaUqyiui9pTIheUI3i9O+yTfJTAdQeW9pyp2jkdI9i6vPikVDkYf
 YbhLul4KHjRNPMorYEB0s9KRu0VkY9KfzP3uOVc9GOHafNceLE49Eyp4Acr6HOdh2Llt
 E25MVszg5XCAvxuSYjaUg5bb7RvHMKKrNcyKDBtjs5PwqSW750i9zCosXWfLmNyFdAsm
 4QldrhGw2cksrr2ID+aN4BplbtgQ7XkFQF1POvLVBbwisQqt8qCap+Ct8bri4zPfh/yH
 wVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=O2dW7ANLcbwksfoB36b2BZaSwVJZbGyuN6/j0lvaHEA=;
 fh=smgHw0JVM4RRD7VrZVypqynySQFc9ulTSsMVtO1hgJE=;
 b=S1wDZK+Vwdtf45iCkIov31Mh/HV7NiyoDRfYxcS4rEFYHz3SibENXL5QhYv7QJ0uOY
 TyB5kYutR6cEiD9pNYbJkenLmEkwkmTrnjkft8GDyYh0IQhnrffEXv7PwZVbxNf6abqY
 LbJ2RGg1Soz8H4d0ACl1/o2vGs4XmuoIQvqGln4bUNamA0pWw31PMibEG2pTWrh/E5bX
 KoAg+Mr4muMDMm1KPMLykTYg61waDK4KlPe6xWKDkYCo40md4tvn66xQXoQDCMEybAjE
 npSYUo2wAJB8KX/ZDs7GRmiIgkLL1SXodYdRjnclsk82rlCwqjAwtBilbQzgUqduzgjE
 iQlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793575914; x=1794180714; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O2dW7ANLcbwksfoB36b2BZaSwVJZbGyuN6/j0lvaHEA=;
 b=jcGFSo3n2t+KEJVvYIn5IGXa3LWNnKCB6QMQ6QlbvkbRsLayfWk3jPiGIpk1vlVtpF
 1sUgh8L3R7Gr5iidMWb4G7XG5rYxgjhEjENs7K011hZkyPEYKz3u9nm4m95vPaF00lrT
 /exVCs+WvsFX+VK4/cyYOD7K74KRZdbTpStboI/yTXx3TlcC1iq8cKBsQPisdObveJVm
 DlOzVjJzOqC9zhFW/3fP0DGHfc9pN3jm6Mk2+KQmru9PoCGH2rq0RCXa6xcSCF6rKTdd
 5xFrngMgDHItnPzKLkxdRhQP6ABJ05YWyGyjvP8zNjmc2VeRA20ljglsAOWHXcN4D7LP
 2tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575914; x=1794180714;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O2dW7ANLcbwksfoB36b2BZaSwVJZbGyuN6/j0lvaHEA=;
 b=NQrY4abCNXLmaZ7Gb14tbJct7sRzfKiFdfiUlHmxdU0VgtulK0ckOyqom1UzitbXfY
 Jf+zxXcyA6XskGPyERPFTq/QbkVBrMJifzFoe5dSeMmZxpNtk4BrJiqOqBKW6WGUTuWg
 0Bgywt1x3Nlr11a0MSPThHoi6e8ASCvLShpRBJqbLA6oo3yCoIpuTsDrn+r48Iw13Tuz
 /RUOj9Y40fWQ0zORMwBoH2DdXdqWBAvUpYiZ4isic2zifX2RPvHGrOanBySNtCIfsbh1
 8suffHYHgjJgN5h5R4DQ9jExUw2V0+awrPwPheefbhhiwsldO9vWlvGVFMLpV2A5qR/b
 j+dw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQo8mnEacdOeH52GRvL4qv+iDraDOK23yfb1tIRGzCMEoEzUI0H/3U8cPePq1131lUoU86iEI06Fo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Al2dc0mxKLBbUMNYy82Ieew1tycT5i/FaxMh2c8/t2Jaa10eI
 Pgke2ZnIOiO6LJ47w1fE0yONqb0o7qV2U9ufqJfErz6ieGHo3v5u1WvIlsvRsWMg4dVBbMiGKDF
 jQq1EfSDWPsfJEEdFm28tlO6tu8AiGYo=
X-Gm-Gg: AYBFou29CDC3z0YrxmNI8sf7061THqA4WqX6gGpGXd9uOaZRSiOcj9uq4zjJ8wIN09o
 D4B2UezX8SzE+6RT4XDE4kzUZ4DWrB1L0x3f5qk2lab0iQ7Win5MJQ3UH+5j6orlN/r6atbcN1b
 ZlUwEZj8Yiopjgrb1knTcfDcq1kyogCWU8DXqpiXL01imSiTXtGs+yLZlfy0IcOU3eHQFOm70+P
 usuw+t6WiFILT3KIw8SRTxGnaXFXntBIp+BiBKVC2WUvoizG6D0t2AFfmLoG6Q319+ux05u4CCV
 5q8rrMmkKcVvyDMSuLqQ5UPagg0fqafXT6jnbs3HEV2P5ED/HgRK08WZGZi0n5su0Y8knXJtY6V
 IEe+s4HLnKjY9w6WrDCErsWmDi/qF2KQP6v61p3Zbvx+4sprAfxDOEd7zGkwlxw==
X-Received: by 2002:adf:e001:0:10b0:48d:f470:6b3e with SMTP id
 ffacd0b85a97d-48e6e30722amr14512940f8f.13.1793575914027; Sun, 01 Nov 2026
 15:31:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Arnaud BERTRAND <arnaud078@gmail.com>
Date: Mon, 2 Nov 2026 00:31:42 +0100
X-Gm-Features: AclHuK_KIdBX_UwH_WtDT3ovTG1iRA6ym5LzcTwWz_yv77CTIDTVYQQiG5byNdY
Message-ID: <CAGxFSwnJYc03fN+XWU8oLW9EbXhmetQuj1s3-m8UdZHoBdGJ8Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Oz Tiram <oz@shift-computing.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000003bbed7065f3f6f61"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003bbed7065f3f6f61
Content-Type: text/plain; charset="UTF-8"

Hi Mario, Alex,

I have two dGPUs : a Radeon RX 6800
XT and a Radeon RX 6800. They both report the same PCI identity
1002:73bf and each has a different VBIOS.
I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
outcome: on my machine the device-identity fallback actively breaks the
second
dGPU.
I patched my kernel to remove the fallback, but I would like to have a
better solution for my use case.
Would it be possible to apply the patch only to APUs ? That would keep Oz's
APU case working but a dGPU with a stale bus number would fall through to
its own ROM, which is the source that is
guaranteed to match the card in the slot.
I can provide more details if needed, I am out of my depth here.
Thanks
Arnaud

--0000000000003bbed7065f3f6f61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Mario, Alex,</div><div><br></div><div></div><div>I=
 have two dGPUs : a Radeon RX 6800</div>XT and a Radeon RX 6800. They both =
report the same PCI identity<br><div>1002:73bf and each has a different VBI=
OS.</div>I hit the same VFCT bus-number mismatch on 7.2.10, but with a diff=
erent<br>outcome: on my machine the device-identity fallback actively break=
s the second<div>dGPU.=C2=A0</div><div>I patched my kernel to remove the fa=
llback, but I would like to have a better solution for my use case.</div><d=
iv>Would it be possible to apply the patch only to APUs ?=C2=A0That would k=
eep Oz&#39;s APU case working but a dGPU with a stale bus number would fall=
 through to its own ROM, which is the source that is<br>guaranteed to match=
 the card in the slot.=C2=A0</div><div>I can provide more details if needed=
, I am out of my depth here.</div><div>Thanks</div><div>Arnaud</div></div>

--0000000000003bbed7065f3f6f61--
