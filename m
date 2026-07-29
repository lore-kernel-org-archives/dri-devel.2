Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16065C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F46F10EDF6;
	Thu, 30 Jul 2026 07:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PXJiLbL7";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D72C10E07E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:53:31 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so1760220a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344010; cv=none;
 d=google.com; s=arc-20260327;
 b=ARh+CVu/T+gt8F+wWI9Z9Xf3jierb7Llo3ltIH4p8+Bpknv+uDZu5FeH/TdVQIf8yp
 39tIeI6Nj8KgMWc9VabuKT1IDjTaDpInZHDG2hUdhWZBay67HnHqdTBDRLz9iUKmindr
 tRUGlmnesII6807EXIaIz7JHyjoNAtyBtF2av+7lqsAJ2cDbRvHL/pQdgtTLwdtbbwid
 w+Dt/xmTNZI2nKTw4L7NbVfMlPtAvLgu3YqW8k7EaC2VRQHNFpnI1Kf8iBMoL9QkqUhR
 226Z7U7s79dMjTdoPWzPq8eDmri46O8vLWteYYvDdCM/EJuLvejazXQI2CxwBN1R8nzs
 h/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
 fh=dxGMPEQgb5Dnmjyij08XlrXgghTyQXOH1MUsj4zQmL0=;
 b=lLJEZ2266EajhAx3sOrCb0jVb/fle7JY15ySI1XmQBWDsVTdfa72wqSwuzPHkju+6Z
 w1v7QI1dJ6QXRSzQuA1bzpTUld1iW/mEhNf/rYf0v7sd98xj29Z5qrpFkazgSypxhWJY
 TDsEnoRyT8TtDX3HAm+03mcgWIIVixc6JaEW4BIc03yepux/6NzOj87nlTX4EQXvwYnr
 iPytSJ6vDQkBoRNr8MrW8ozHxZMEUb6cUccXwUoy+jj77taMR8OJK7m8n8G7sZVEl7AB
 X9hS364/cC+F0Sh7uS4NM01iMIjgHtxEQ9Lx5lAmoOeuIWe/JLMrzWJZo4VI+rb0WJ8U
 woqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785344010; x=1785948810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
 b=PXJiLbL766/coKAFb/WWX+c047o6kycbveImyzXJUijDV5IdNXuNzuHp95pUBWu9wN
 hNwmIuRWG7h3n/3XZojZl/Q4WX7nJGBDmRqI3rUzXIHm0ODJWvPOGJkuvYqY9br0mzh/
 Mk/+WNF6Q7sntqGj/SDBhdMLkD58AGy6OoJoKEFW9zl6UmS8Cav1/1Dx5ClwDguRy7g5
 uFkYk8p3CQg8/x5UZym2Br/EB35kaeGeWy3YeqFGiuZerFs+TM7hLp0KLr7xt0k+1oWS
 a5YW5hIIgFzBs7HqLHChQdpZ9w+tZhdD8S/en406MtKoMQBYYSydsFzNBg5a7iX+2+aB
 0Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785344010; x=1785948810;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
 b=RaG1Z6vux+mVJh2/HkaYHJ2dqOyj2Afhys4oVoO+ZqLCIHZLwB3x+0kIKXOo8Z2TL+
 x1LE11VEh0qQdGb9lN7Dru6oB6aQBAk7QYM92NDRkgIM8cnhuMob+KGd5WWqFkiBy16X
 xeVJF9OTuragYneNl/JxHYFneRuPlU89kVnGP+jGI/aSIKIIUXw8p53sDi1v9c6Sf2PV
 gBooBhdMPn5HpsPQMBdV76yvz3Fx614IRfCVxlNYfOdXFTZ2lqBB2iG++fl79SfwPDsI
 kWUz08nu9RSt+ciIYDAZssPPo+KM2byn4QVRFiBUEvVx6qHdYAYZH1nZkYhzhk2D//ZB
 lcUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMvi3DX2NIMVqs9j5fSVeoWL+Jw4QOKbzLqXC9eOG1PErhaTsqR0o5w6/1UHDxyWQsiDpKI6y/WhM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOfwIL4IbmK8l2dusgN6H3tp4PM3xeGsTkqU8zAsXwiCN5JF4C
 xJSM3kd6SxTIQE/UFHT/Z9aerstZuKo6Wvf8aImp+M0YCBZGd3Gp0uSH6gtXpJcs0EnOs2XCe+4
 8vJSCO3Fi2puIdK0l3W7YAKljg+IJsQ==
X-Gm-Gg: AR+sD13eNYGo1iFYFq+cnWOpmwDgaeG0I/9kJ0Hlx4gT+azYCdQt2gd7JyOS1RalVLn
 rlUzBxZNqhKRX5qGO2nnOejRfGlKhSOGRnLBWq+aLkLyVaMEXfF5TcVY2BFeXVeHHAPf5BwujML
 pKgKO3tm7uh6pzfAPFBRhLILgMa8jst+kx5jkKDEssv5tivgG451XW8T9jT0/FdOVCAqneehTGa
 iItFsNl42kJB8QT8HhuPTg6M8K7qD2dFD3fzQ8baNAIW0ofyW/5FzYYtiKut4xvUJ8C2u9P8FN6
 xSKvs45FXDcA0yqitW0CgAmgGCmOB0NTmWrIh5fdc7UAkPdr8Su7fu/dbJjLEsQx52m4wTxxpe6
 fVwTAbsUEQuY0gXyshg==
X-Received: by 2002:a05:6402:5018:b0:698:ae69:3992 with SMTP id
 4fb4d7f45d1cf-6a0349ec697mr4404066a12.16.1785344009469; Wed, 29 Jul 2026
 09:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
 <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
In-Reply-To: <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 29 Jul 2026 22:22:50 +0530
X-Gm-Features: AUfX_mw2n1ETd8ASN5Vcu4oMSqcqp6oKyV0zFdoD8l7zvxibNrqO80gPOx-5lV8
Message-ID: <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, 
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:55 +0000
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

On Wed, Jul 29, 2026 at 7:37=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
> >> +static int io_import_dmabuf(struct io_kiocb *req,
> >> +                       int ddir, struct iov_iter *iter,
> >> +                       struct io_mapped_ubuf *imu,
> >> +                       size_t len, size_t offset,
> >> +                       unsigned issue_flags)
> >> +{
> >> +    struct io_regbuf_dma *db =3D imu->priv;
> >> +    struct dma_buf_io_map *map;
> >> +
> >> +    if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> >> +            return -EOPNOTSUPP;
> >> +    if (!len)
> >> +            return -EFAULT;
> >> +    if (req->file !=3D db->target_file)
> >> +            return -EBADF;
> >> +
> >> +    if (req->flags & REQ_F_DROP_DMABUF) {
> >> +            map =3D req->dmabuf_map;
> >> +            goto init_iter;
> >> +    }
> >
> > O_DIRECT is checked only during registration; we should recheck
> > (file->f_flags & O_DIRECT) per request.
>
> Nobody should be able to clear O_DIRECT, unless I missed something?
> And fwiw, io_uring wouldn't be the right place to do it.
>

fcntl(fd, F_SETFL, flags & ~O_DIRECT) on an already registered, already
open fd succeeds. The consequence is that subsequent I/Os switch to
buffered I/O and cause silent data loss. Something on this path needs
to reject this combination.

> --
> Pavel Begunkov
>
>
