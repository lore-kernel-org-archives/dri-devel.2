Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB04606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UtOMjGvX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAC511202E;
	Thu, 29 Oct 2026 08:03:13 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8E310E083
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 18:12:10 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-36a0f27c9f4so1968969eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793211129; cv=none;
 d=google.com; s=arc-20260327;
 b=M92+bkaRkqW2WdrJ6R+Hjd7iFW9S1ReACFBBp58CjNiVwMexG58T8rvwLpMOsrEZkm
 Z7AcycZKf2uZEFhf9BUPiymvCyUE5HtRYlGBFnlcyVNFFh/bERihbYinaJ22uDu5+s+L
 sHGG64o5QzpQ4LXJC/NdVg1zubzc+rv3O4siZ+0dZwLcbHwxNdVq3XJ59ZpDdYbPmRKV
 AoNkuhaJYCW04ueFvyyorlOBx4tNxg5K607iXICDv1+XNEQmxDRs1BL1XAQpxEZf004y
 tXwWgh7HG4OYsmGi9bgyoj/mSwEzZdAf3xHdi7kQhwuyztSBb7OuYyd4f8lcMrxEh31Z
 0xVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LaRGx1dNEWPdR/HUW5QFXw5geXVqN0PcRJZxfDPcq4k=;
 fh=VPgln0uFUbKdQ4TdIV4/cJOLXPC6kpgaFquVPTX6pe8=;
 b=RJZJtKz50P+CE7KQ7VX+XjwX2nT9iLeV0mY/VePdVL2d/Q/LmIGn3J/tebzjfQdqrY
 ATnrkvygwg59cOM7N7SioYv1gOv24+l99rz2Jd61KphCB+1TsL4vbVYqrs0ifon3ZM7G
 1pzzNRWfMj+DiEeWgCturQtM0pJQxDzXMqnVbHxemwuGQrunhhS0mctn6xPxw6MR/FTD
 GdgYaYHXEL1NXUqC9sHLF/Lfx8684+MQ0SD1os4dDOljtamqYlvizh3/T0uOWQki4swi
 IgSNvrFDoIZX8/PwmI7L+4oq9eCweyDpvxomodpYg9Ficpwy1jL+I31J+wPH0A7rBgKT
 mvkA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793211129; x=1793815929; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LaRGx1dNEWPdR/HUW5QFXw5geXVqN0PcRJZxfDPcq4k=;
 b=UtOMjGvXHESGGiJ0XsbmxbuWc0PgKzQs6CCuby/cXvyR4K9m9kWF09RaHifZN5zC2y
 C8FVeNPKZEgmMeHOW+qAJOhrDhpzSUlUcI4qsNfqjbKHSzD3sx5Sw6QC3BL2Rui0tUCT
 kUMP8pFyHuC9ZG75u8ldv1lv4QaSsI0Ih1KgV0wFP2iTIBih8cho/7OZbNU070Iycnom
 TJgHlTBbCGt8outhGurXCl7OZ3cgD+eWICoM9t7sOz+01YQQRrE8uSPDhyJ2rMBN5Afv
 mQ/pI6k2dgkCCAtaga+ozjLjYyhN1SVXIBN3cY0AsoCDX0qvjY9iQP7U9SkXWe2upq9A
 dkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793211129; x=1793815929;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LaRGx1dNEWPdR/HUW5QFXw5geXVqN0PcRJZxfDPcq4k=;
 b=yjy9bHS93O2FLKE5Lt8d5uesmfajl1mhcsUG4r7vmgLkppkXUIq8zQj1Lw+yc/iOLr
 6ojbFp4/2Ozf3rVGfXWVxMGl2X5E1KLizU8vHMRV0Fq/36J01G1d7oOzjhX6G7BUm3pm
 gif5J3xsEu/FQTkN7ZMygrbTw5ncfw+fMnZz6jhYzplM4m8eF07JvphxCrhi1X1PAmGJ
 093jVhKQbziMQf4pQ3sZ+HdVLfpJw9F6lFNOZX79cUg7jIBFPk7dwViuV6bsk3zI+OXc
 sQvhuH8m4AIwBwKEJhWrTjDhY6d0yyp2R1+R4HoiTAg3+3i61z7pIskFYj+hMEkTpk1Z
 D0jA==
X-Gm-Message-State: AFq9FYLISQxPVygvCIRuORp+zQbcu2+WecofYE4RNs8ar5DZhpvWR9Dk
 q3jYuGYOTQpQAP0AkUmoU4TtwigJ8OKowX8eytqcEi0gBbAxHSA3/pSHirxYGDaUozMPzq40xG1
 RFZtJxmYtXgbLUWh/FVB5vPc0eb/AjF0=
X-Gm-Gg: AYBFou3VdzRsd/9qdynBZWP15NlYzeibc3kxhfU4wOwXcgkkNpxyrf4mCjGuLl61FK+
 PmA3wHWUX2+9AYprZkTk2vQi4YmvGLnRhRz0TbYSC15c/cbJZqpvdUKlnHXWwNfr7QHpS/oHEyJ
 LBz3IsM6ml2sUSWxtabHGFgVcH5cqnEahsO6k5rxP8b4MM5YVhiTEF8tciHyDORUU+iHbyHDYeB
 oAgl5gjq0qxZhE3WpsBWF/zT4Bf3daOfu/0WWdQa0jpRgBQbiJm+k0jCzQ5ejTI8AJHM/3Zhe3+
 gUFoyxxTySIlMUmPjSF0S5h9BrYBs2tXzfpZQVrQe5CabxRjIhnZggBxzXfPdEOGwFT7n2Q5dgX
 g5TccDXqdA0uYLI+ngBs3v17U34WB4a0VxtrDvGo=
X-Received: by 2002:a05:7300:e9c8:10b0:36a:18a:e02f with SMTP id
 5a478bee46e88-36a203d2f99mr5121130eec.28.1793211129415; Wed, 28 Oct 2026
 11:12:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-6-henryzhang62@gmail.com>
 <sashiko-outbox-188230@kernel.org>
In-Reply-To: <sashiko-outbox-188230@kernel.org>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Wed, 28 Oct 2026 11:11:58 -0700
X-Gm-Features: AclHuK8-5DUjhx-8H0W2_S57CeLeTF3woQXvHvgC4ykQsqxBjId8MHZi9iiIIWw
Message-ID: <CANTW0yq2H=SjZY=zHZnUQWB5Mf6yfD+Wy=CMJ3saKRf7JhjYaQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/vc4: dsi: Recover from a timed-out transfer
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:19=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
....
> [Severity: High]
> Can a late or error interrupt race on dsi->reg_dma_mem in vc4_dsi_transfe=
r()
> before disable_irq(dsi->irq) is reached in vc4_dsi_host_transfer(),
> corrupting DSI1_CTRL before vc4_dsi_reset_and_restore() saves and restore=
s
> it?
>
> When wait_for_completion_timeout() times out in vc4_dsi_transfer(),
> dsi->irq and INT_EN are still enabled while vc4_dsi_transfer() performs
> five register writes before returning -ETIMEDOUT:
>
> drivers/gpu/drm/vc4/vc4_dsi.c:vc4_dsi_transfer() {
>         ...
>         DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));
>
>         if (ret)
>                 goto reset_fifo_and_return;
>         ...
> reset_fifo_and_return:
>         drm_err(drm, "DSI transfer failed, resetting: %d\n", ret);
>
>         DSI_PORT_WRITE(TXPKT1C, DSI_PORT_READ(TXPKT1C) & ~DSI_TXPKT1C_CMD=
_EN);
>         udelay(1);
>         DSI_PORT_WRITE(CTRL,
>                        DSI_PORT_READ(CTRL) |
>                        DSI_PORT_BIT(CTRL_RESET_FIFOS));
>
>         DSI_PORT_WRITE(TXPKT1C, 0);
>         DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));
>         return ret;
> }
>
> On BCM2835 DSI1 (where broken_axi_workaround is enabled), DSI_PORT_WRITE(=
)
> calls dsi_dma_workaround_write(), which writes the value into the single
> shared buffer *dsi->reg_dma_mem and submits a DMA transfer from
> dsi->reg_dma_paddr:
>
> drivers/gpu/drm/vc4/vc4_dsi.c:dsi_dma_workaround_write() {
>         ...
>         *dsi->reg_dma_mem =3D val;
>
>         tx =3D chan->device->device_prep_dma_memcpy(chan,
>                                                   dsi->reg_paddr + offset=
,
>                                                   dsi->reg_dma_paddr,
>                                                   4, 0);
>         ...
> }
>
> If the threaded handler vc4_dsi_irq_handler() runs concurrently (for
> example on an LPRX/TA timeout error interrupt or a late completion
> interrupt) and calls DSI_PORT_WRITE(INT_STAT, stat), it overwrites
> *dsi->reg_dma_mem =3D stat without any lock.
>
> If that happens during the read-modify-write of CTRL in
> reset_fifo_and_return, the DMA transfer can write stat into DSI1_CTRL.
> When vc4_dsi_reset_and_restore() then runs under disable_irq(dsi->irq), i=
t
> snapshots the corrupted register via u32 ctrl =3D DSI_PORT_READ(CTRL) and
> writes it back at the end of the reset, leaving DSI1_CTRL corrupted (for
> example with DSI1_CTRL_EN cleared so the block remains gated).
>
> Should disable_irq(dsi->irq) be called in vc4_dsi_transfer() before the
> post-timeout register writes (or before reset_fifo_and_return)?

The race is real, but it is not introduced by this patch and not limited
to the timeout path: on BCM2835/6/7 DSI1 every DSI_PORT_WRITE() goes
through the single reg_dma_mem buffer without a lock, so the threaded
handler can corrupt any register write made from process context
(transfer setup, the bridge callbacks, the existing reset_fifo_and_return
path). Moving disable_irq() would only cover this one path.

I'm sending a separate fix that serializes dsi_dma_workaround_write()
with a mutex, so this series stays as it is.

Henry
