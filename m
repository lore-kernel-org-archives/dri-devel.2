Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCF5CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 17:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19F710E241;
	Wed, 27 May 2026 17:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="AaxabphA";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="iNeyWCtn";
	dkim-atps=neutral
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4351010E241
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 17:03:44 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8E1FE7A0073;
 Wed, 27 May 2026 13:03:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 13:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1779901423;
 x=1779987823; bh=W7sJHu3X3lqZ/+F+nLKQX33IaAFOhmRus2xF/6aombA=; b=
 AaxabphAoo6w78R+giTZxGMumpkaYExgTgANkm0L7z049fjebaxLG34fGrEBRTwM
 0mxx2Rmc/XguHJmNgAJRNfh9xnVYzOGLT5/6ICaVB4KZ5QugxDThviUsC5lXgzch
 3nvGnR0ntdAiNEwb6EXszCLOmA0PoFrkuxWbpKaimGJu7fZMzDHtcBmTzrxUxCoU
 EUj3A/rk1Q8VyYhjtX1jcNtuLkyfY1lHDckAZc7cdPEWn1QXO/Bq3M0lJkvW1bpW
 2O4cuQs5wJ+5LOwCEMjB4T+YNw1WoHJufNx8jL+/iAAG7doB+Zi7HFwW+43AQeV4
 6rSZKa8QucaleZHcd4kpnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779901423; x=
 1779987823; bh=W7sJHu3X3lqZ/+F+nLKQX33IaAFOhmRus2xF/6aombA=; b=i
 NeyWCtnDfJBw0XfwXA+Kba/WTFuC7S8UHIh7oJzMJWzOfqAazyIvBfykWzA7ad0S
 1uDDx5f8qr7Jux/Jp0WNTRJs3UzQ/59RB+qoZwjR5qgqqPocXG5BxiXoQBcN7Uo+
 EXBRehRLY/PW/uoRSNTZSb7q3MLaW/mKUrtESTUe4uw0lRGkuqhzVwEDwZZPFd7J
 JrzdSeddUpRJWNcz8DhV9MljEQALYGfbDFwdvpDoYxoVNHqoRgX3Ga4dwAA0Ha6g
 ZRoPs2Lhs5RpLXVh4LE2en7nQTGhZ8/b+921ib0rCzqYpYP1+wREspJk7qyuyvSr
 nJDR0DEA84czK18SkF7RQ==
X-ME-Sender: <xms:7iMXal4seHozvvDvAA9MM-LrnGPT_6AD7eO9VZY8AeIY0kDWpPWqow>
 <xme:7iMXaqcnQd6i3eyIY0ITia-eu54QBdiVFlQY0zPZNkRXwdaIXxpgIA0gaXXWhcPGR
 hk6eb9bUYTj8gWVy3On0M5PH-IwtptOJHeahrUluO_fOHWyNj7VFw>
X-ME-Received: <xmr:7iMXasH2_KW3WwEkhodc8P4Evg3OVr1J3tlDI_K3wVHIEQwXLIBzYFTii3g>
X-ME-Proxy-Cause: dmFkZTGxcVZESYa1ffk92r9u7bA5CJRTGW5mmmN1n+HTRN9GHNe7b0bEFT1hm4KYChXyqK
 9nz8ZYt0Fx5NUXMS8jZogLQNwBocT39E50Wwhz9qWYNH+79P69GN3uDGGXdgmSdzLm1r5P
 bkgWmjCeL5D7oaTsJMN1wmLMkDfnvJaPsjo9Bg7dSmeAEWmgWYzPbiHM+hw4pojGhw7M7c
 tErY5ufRoYQszzxMddGV/UwNpRRFXmpwO47lEHpXJy6H7e+Rwfv4TXluSH+L6B+C4V1K4q
 Ti6nlCPzGKfjeQ75Bb/GW7vcsB4DNilTIAYDebmMu3+zwtKnWdEEVDr6wbjaVGnRnbbol2
 P0A4hcvRhQ8rG11feiZNw4CKpev/4N6/CnNZJfSRCA8Pj5hqTnR6nlvhZer2/3xl4nwp2I
 BXiW7qCYmtKj/8eWvQ9uZ47s/NjVW0fE+3gDKxmranb0qTfiEzERX1wFjZ2RodeOXtPByW
 XJAihLMQme1uOfSXE4H0IWYRXxichWw2o6N56L5e3M0sZfDP1469YumJtbC4ge34SXsS5J
 ocj6+FDqOmbXJYtBBvP9JIfINw8u76k4b/NbuAmgPGdmDT7wI/5SqI5a2rF+AIs+3q1kPL
 wQm0C478OgWX5LS+0Ch9zSRBvbMtlYI5JCyzN6ry72wEnWsjPec7mTf0mKwQ
X-ME-Proxy: <xmx:7iMXaq7VBX5LZI_dEfC6hxsiS3uwvkSpIC3WImdJkqseUI6_jw9-ig>
 <xmx:7iMXavvWL9sCyz_j7015hc7UIAHZDyGnxxuV7p0KCF7oWQmnkVvcNA>
 <xmx:7iMXau9IbgeRrjkf4NhDd5xYZuNC5I1MjCzwzxtt_Inbh9CStiUDIw>
 <xmx:7iMXapnjyzMVxA3xzlhxj94f0o_BdY6G-jsscFnXna7OcWjM1_sKkg>
 <xmx:7yMXamkyoqc9miOMUeqwiZXcioIbaKPYghwpx6v0DHhXoHqQtACSm5o3>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 13:03:41 -0400 (EDT)
Date: Wed, 27 May 2026 11:03:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Konig
 <christian.koenig@amd.com>, Bjorn Helgaas <helgaas@kernel.org>,
 <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v5 2/4] dma-buf: add optional get_tph() callback
Message-ID: <20260527110340.5547dd30@shazbot.org>
In-Reply-To: <20260526144401.1485788-3-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-3-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 26 May 2026 07:43:54 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Add an optional dma-buf get_tph callback so an exporter can return TPH
> (TLP Processing Hints) metadata to an importer.
> 
> 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
> ST table and may both be present with different values. The importer
> passes its supported steering-tag width and the exporter returns the
> matching value, or -EOPNOTSUPP if no metadata is available for that
> width.
> 
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with the
> mlx5 RDMA driver as the first importer.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  include/linux/dma-buf.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5..49eb6ad644a2 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,27 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
>  
> +	/**
> +	 * @get_tph:
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @steering_tag: Returns the raw TPH steering tag for @st_width
> +	 * @ph: Returns the TPH processing hint (2-bit value)
> +	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
> +	 *
> +	 * Return the TPH (TLP Processing Hints) metadata associated with this
> +	 * DMA buffer for the requested steering-tag width. 8-bit ST and 16-bit
> +	 * Extended ST are distinct namespaces in the PCIe TPH ST table and may
> +	 * both be present with different values, so the exporter must select the
> +	 * value that matches @st_width and must not substitute one for the other.
> +	 *
> +	 * Return 0 on success, -EOPNOTSUPP if no metadata is available for the
> +	 * requested width, or -EINVAL if @st_width is not 8 or 16.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> +		       u8 st_width);

Why not make this `bool extended` rather than `u8 st_width` to avoid
the entire class of errors involving an invalid width?  Thanks,

Alex
