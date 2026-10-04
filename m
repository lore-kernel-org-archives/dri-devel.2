Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BA8CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5696810E02D;
	Sun,  4 Oct 2026 08:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oA8kI8Mm";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB1810E02D
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 08:49:42 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49fff6f0f87so9102465e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791103780; x=1791708580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PGsH7rDWkRj8clYSuUGvdGlvrrgMjVS3OseQtK1KgI0=;
 b=oA8kI8MmTfayZQjKO9EHQSiOSeiZwNAzscFO3SvC3EDJdomcmZ1LU93ArAzwZTaxGB
 UQVgP1AmMKxkkqfxKtkEML3s4fkvF3XaHcClFGlM4Fcq3005MjDzQOrMMsfxDhe2d6V4
 4GmTJhIBceneBF4p12efQ7vb4a5qqQGGHodj9Mx6ItlaC3zgo24sIFe5Stv2l+MfHtgI
 yZX1F8AKRoRshXfH/aNn/5XO6vr09RdJ3JfKQr/Xz9x5sm12xK45QW1fh7pGbQjsRwmZ
 6AknUQkkkrBXEc2PM5JA6USB/TquQo26XE+HXawBKZ1YZz8BLhcRva5X60r45rEfQxaB
 dsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791103780; x=1791708580;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGsH7rDWkRj8clYSuUGvdGlvrrgMjVS3OseQtK1KgI0=;
 b=r9MKlxmELVCgqk6xslRqIzJixMprYeE0wBGcA0huL9Qq2cmarkAExRkfuoNjB7ZOWd
 IPbCuT9xrI45tFBnGiYLDTvGU6nk+Rn+4Ns0kKNyFok/e+M1zsAZKXnH9k8JphQSRcOA
 5f98G75DS+9pwXIGGUsUciDsB7x/LCl2VYP2fIQu8fDnN4o3117YjsnTsIDGD7+A9fiw
 SpxQ7+cninNAdZYCWWxxcSRyZ++gnahY6R4YCcLztsE9xzLF1NQf5YpHFYcA71WzIxuY
 uguaaDbiKT6i+n54WlZP62AV/gNZmZO/pd44pjR08CYS3znG1M+y9GMZBPK706mAKLRW
 j+Bg==
X-Gm-Message-State: AFuF++lYDINvfk9skrg+FasNAFmOy0UDQMxC4AQuoAs/fgx/5pSmGVqe
 D0PYZRF4wnavbmHFBmHkS4No76iva2qxIqhJZSuZ44IV8deyiyBtB6el
X-Gm-Gg: AYBFou0+0aOGjrAez5D8u/o5BHCa1KeDAHq+kJDbGWlbf2QpcECOUANxn2lwpENYVyX
 IVEjyXM4HvDE7/IHUwi8bHE6VU/iyJIibQysZHvGvz7jzmoUA0dqw6IGQ1rFUVEv3MsfP7uI7Fr
 56ce4o4avH/vlcHH38TwvkTM7nDx3rtyHQEP1AfLHqfKhHFONhKN9y0/qWvzmutI34Nl/sP92bR
 JDPBT9RgMQEXO9hlLjd7ii0RMdGRj7JgQGddb77fGgm4uD5rMmzbk8zV9ltKBcQ4Fs3N93U4EO2
 8hzqz2nPvXGUGqS0x55KOkuchkuVKcIUlQCy09pfsDI25r2vXr9Ee+Y9EhFXpHAvWocXBbXqbRw
 3z9iigYVxR6rz34IWgUi485ykg8sCm5coawGCBefwXDyLtNehrKMYqHX03XY26yinhc+6Tyhmr2
 x+nOx5weLu7q+/rwMIzT8DxufLu4kPsxFFnVBYdl3RNqvKN9XWSF2Iq5I5O5rbyrp0CcXpFqL9x
 EC80cpDzrw7FsUAcgyIdUjxh7Pvwq3RFDXjknYsW1gQ8VjthXnJKCktkIuXUZX00xQ=
X-Received: by 2002:a05:600c:3b1d:b0:4a1:7033:5b55 with SMTP id
 5b1f17b1804b1-4a170335d02mr17995165e9.21.1791103780373; 
 Sun, 04 Oct 2026 01:49:40 -0700 (PDT)
Received: from localhost
 (p200300eba703ae00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a703:ae00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027f2a4c4sm251131045e9.2.2026.10.04.01.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 01:49:39 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [RESEND PATCH v2 1/2] drm: add edid_overridden flag to
 drm_connector
Date: Sun,  4 Oct 2026 10:49:30 +0200
Message-ID: <20261004084933.1440705-1-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003175620.245AE1F0089B@smtp.kernel.org>
References: <20261003161525.23600-1-johanneswueller@gmail.com>
 <20261003161525.23600-2-johanneswueller@gmail.com>
 <20261003175620.245AE1F0089B@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Sat, 03 Oct 2026 17:56:19 +0000, sashiko-bot@kernel.org wrote:
> Does this new flag also need to be set when falling back to an override EDID
> after a failed DDC probe?

Yes, drm_edid_override_connector_update() applies the override without
setting the flag. I will fix that in v3.
