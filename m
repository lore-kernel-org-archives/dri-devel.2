Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61038606A884
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LN4OPmze
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB26910FCF4;
	Thu, 12 Nov 2026 08:36:36 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C557810FCF4
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:36:30 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8a058315c79so2109120b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794472590; x=1795077390;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e1LIqguyGHyugjp6T4wuUZqSXt5F4ivfryPqW2wGYPk=;
 b=LN4OPmzeIAOIcerQyApT6JYhKdItwQG9yU9QqkAVpXsgnr6LZidb2HQr+2aYCNgb4q
 nn/owsuRIIUsPorugQLub8XFRTCP8CstHxdtc8ef7Zu65wTc7P/FBU1FH7JXs5JrVqvw
 hySa7aWKBis7XGw6cROvyMrlBO+7DsgRS1WGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794472590; x=1795077390;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e1LIqguyGHyugjp6T4wuUZqSXt5F4ivfryPqW2wGYPk=;
 b=u/a/vP69g8/t1WXCKlkSq8hGDNoGDlpZxZ0yTqTM631gRrbDNJGqmv2r3s4c15p4c1
 NIgX2v+YdBqMZ5Xh+ONZlCI9PQYNg2Du5WHH5Q1gwgK3Q9kUag9i2j2gdgwclkQphK2q
 3292t4z4AQ9QessY/rJn/fXVn1G3gEserv0TT6KX+klUcYkHmfMQqPXyTVA4MoI/nLZd
 YuuyBlw4Q+GINTiQ9g2TbpyboCubZ7k3HrJldyBWs9cCx2fL4/umqHPdfreUURWYoS4a
 B0ECBAY/csL69adlyWlVDWo4Wr1iAgZ89Snws629u0HgbnnjUGnMuc+T8Dxgcq7V62S1
 A6BQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEsNGUno+rUZ7l1j/wnP+AZn/BeIZX3JTnBcYw9sREGDkSRh7nB2lwhAX6IEynIAtioHxkS8a8P8eo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8r3YKO9RKELCcvZJXi1T90AVAdfZy1H55G9WxH2vsgtdloMrFo
 +IqoeT6O7KZ5hZAeJchaTyMfdb2HuKCrMsy/xDEqMj69H0PVxVtjmO9ix2J8ufDSJbRFeyI/GF8
 qtoBTdQ==
X-Gm-Gg: AYBFou2Op1IooEqKai1+hP7TfQWOVqEjzX6oT8pgJ+/ROr8MOQRi285Zv+VGMpifrrm
 XffZ3eHKhzvWiFSyAFrkDx65dQ3UwxXkzJSgsZb06OqnGCS27RfsRtqNPjyxRtbgjPZ3YwiJdCc
 Wyg4H5D2XHq7NpAmbweevnlRmZmbCz0wcHqLmz9EOPE9YcMFBNLGZd1hQkVAGLPioQQeRm6sEso
 tqIy6I7nazt2uRu7jldmnt2yBVlDtUzFM3z2vHKaUkLk1lMXwkNspGxSTkcZFLspDgsWGKdykoR
 XDuU9LMeLeCEJwvoI4t7RJRRQi9XirH/Eh8xLi2s1teEkyH3+GCfuv1SY11HtZhggLA368ZtJSM
 LBtcIv5x+WjLlKTv0VNLIe2XEF93HkbLskPEbrMSS6/n+yvzTvDiv6Bhzvl+suvQ/NkZiJ0Igoa
 w0v+5i76EgR2YnJ5wod5tvt2UiXg4Y0SmD4ibzg5R+ucYXY5SgtFSoxdYnyWRvZzecDO5JUrp9e
 snP+3KCocHQ0LhDTzUB1CyQV6YSqNZkEGxU8O5gh3b7I7qR+CgywLwnrej2Aj7fr2rIFGkYVBNB
 E7X5qvRhLLku1yZE7dNs/whKc5tQ/Yrzomn9oZdNaqT0MtW/yV4wGgMYXnpbV2Hni/7KTzB3fOg
 eeN1VC2v68UdS
X-Received: by 2002:a05:6a21:9216:b0:3e1:9071:acdd with SMTP id
 adf61e73a8af0-3f2ff0dc5cfmr4985795637.35.1794472590279; 
 Thu, 12 Nov 2026 00:36:30 -0800 (PST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com.
 [74.125.82.177]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdd8d79d406sm2431509a12.17.2026.11.12.00.36.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 00:36:29 -0800 (PST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36f8cdd30beso7474104eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:36:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGcy0uHRDOxbE2a54vOQxrhqQSyWfZVbJ/05DD/+o6v1P4j5GJYquqwym8cUKakI8h34Iw9sk81ygo=@lists.freedesktop.org
X-Received: by 2002:a05:7300:fc15:b0:36e:a265:8ee with SMTP id
 5a478bee46e88-37686171585mr5111950eec.18.1794472587019; Thu, 12 Nov 2026
 00:36:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112061736.4014993-1-yidilin@google.com>
In-Reply-To: <20261112061736.4014993-1-yidilin@google.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 12 Nov 2026 16:35:45 +0800
X-Gmail-Original-Message-ID: <CAC=S1ni1r2yWQOntVCJxjU+DkHAVb=gBEE71VN701BxeMCxN+w@mail.gmail.com>
X-Gm-Features: AclHuK-lH1eh8S-718xAEgJiftUumas93CKfUyPQy8uMkB1D_yMS7HqTV46k4yw
Message-ID: <CAC=S1ni1r2yWQOntVCJxjU+DkHAVb=gBEE71VN701BxeMCxN+w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dp: Wait for the complete AUX reply before
 reading it
To: Yidi Lin <yidilin@google.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 2:17=E2=80=AFPM Yidi Lin <yidilin@google.com> wrote=
:
>
> mtk_dp_aux_wait_for_completion() returns for a read as soon as the RX
> FIFO write pointer is non-zero, i.e. when the first byte of the reply
> has arrived. The rest of the reply is still on the AUX line, so
> mtk_dp_aux_read_rx_fifo() sleeps 500-1000 us before reading each byte
> of an I2C-over-AUX reply and 100-200 us before each byte of a native
> reply. The FIFO is drained this way even for DEFER replies, which carry
> no data.
>
> A 16-byte EDID read therefore takes about 16 ms, although the reply is
> complete within about 300 us of the request.
>
> Wait for the AUX receive-complete (or 400 us timeout) interrupt status
> instead, which the write path already relies on, and drain the RX FIFO
> without delays. Poll every 20 us instead of every 100-500 us.
>
> Reading the 256-byte EDID through the DP AUX DDC adapter drops from 266
> to 6.5 ms on an MT8189 Chromebook, and from 547 to 23 ms on an MT8196
> Chromebook whose panel defers every 16-byte read once. A 16-byte DPCD
> read drops from about 4.7 to 0.5 ms.
>
> Signed-off-by: Yidi Lin <yidilin@google.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 64 ++++++++++++-------------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
>
