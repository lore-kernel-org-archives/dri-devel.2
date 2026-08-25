Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48874C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9425F10EA33;
	Tue, 25 Aug 2026 12:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VqGb6wsp";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E38E10EA2B
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:33:05 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-81e8c68c0cdso3775287b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661184; cv=none;
 d=google.com; s=arc-20260327;
 b=ndRUg58Z1/o5MrNkaTWPZAGq1nZcs9cY5bG8BXIyM96nj/7/3ws4RaPBw4IU0axtc3
 h8pMVw8a8ArMqpAf3Jk46MUDE26AaUy2rqffrd3OiOgg9nwQY3z4R6sXA/pMRtNNfFSC
 O6WiBT8fO2G9ozH74Y4n1bfGSEb4uz62KT7ECBCub/zFTsFQyInnwAulmulLGWoOsFhh
 1gPEEKHVsjuLsm+YhxEJyGGr1orix9Fab9Y1tUgsG5sZhuB2tj50GbNR70IMvUmOSH82
 Oy62zsArYKf+VLxTas9bV2JJzzto0KGK8GPK6WsHrpo7tBTCr+zqEb8VWIfDvbcOMyQX
 zMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
 fh=LRPG2oxND449xvz8DDlR8WeFZ9NOv8oKYCbPno/OTV0=;
 b=gojXAORN/DBGsJxx1NXhtphq+6I88f3NPylLqNGG78QuGiYKcPnZJ0rKe3Wl969LTs
 mNg/4eGdA5i4o3x6YpEgxt3DufJCZr3xVRSBnMq00NQOgxCo5Yf8UeD2bQnoBXHN8KTP
 pJyqF89mIe1FgtnWMeBdIFvum33ZiMd8+NCYLh4lGWefOSdAYwWl020uRAxNiI78w65L
 CIOx+zSR8zd00eYvsSh+S9ysC+BcS6RwwQGdTGIAfpuBidYXuwaqqshJuvHhNZT5y6SP
 dm/AeUCJIxQr0+xxb2CYszRjw5rho+YuBApgfvUVZF2/jt2QTeaDndVt00tE48U0rvIK
 WrFA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787661184; x=1788265984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
 b=VqGb6wspYUJPesC5AP8BI1wHAdXVUdyKTz1y7kqGVy0nvE4g1HOy7Lv9Q012dXLNR0
 y15AqjxPDRMn7FcCcxyvkGWePoneQ+YoSMI7sKgDkYw6S4e7fGsMrZgrP3GeIfDIp428
 SU16sl2aGOz3w4OxUQp+aASu4DcHADXQzHq4JxYMQvPGD60+zMAZSTqf/Qps04kR7hJs
 2fUtKuq5+CreEehiC1iY3UtsV7abpeVUoFcIEzzH+yFDTE7uPycgoim+ybAY6S0ZOGFx
 J4DtkJ5MV/X/H3QVdogd+TBOZH6lxGk3aSiCfvt7u66TYpF0bxlasecE8PoWUd7X5MJP
 Nkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661184; x=1788265984;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
 b=dmtuerSC/2a9wdoGug8E8QB7QOq6IIMvFbJdq5DZcoZ/k9mFcn9EjWvqAdUpTw1iC0
 9tOcG1G8nTrH+cck3e2KzcKQD4HQazqKXr8kWik/+wshQWf/Gvunam71ejpp+TXTeLm1
 +cYUSJn7SorQkV8m3NqrIAwFJpQGW5hoKVuK1WjMdyMCkSy/9xTb6Nyiac+LCamdJOnQ
 z9SGNOxoo/ImsqeQyTiCHEOFOpq7E+EA9Ase+lxma+jWI1dMETVWHm+ORmBCsn/YbrOr
 t1m4I7/fynnRKZBvJqwTL4xd2vMieMbGuoCqBQ0BmOBC95KuoVKUrYCRWyKj4+0lRJ1j
 jNMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIaivOnSayrArnrPWEdwXOrWeSAoWjEBhZdWkag3nhBTbRtHcSCjN10DB1nSqx1ThTJLRwFf07U8k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nonTZLiS/ZdVQIx0LuYUiXRPbtbVoZDZWgzm31UcsUsa1Y1Z+Y
 wiWcVlqTCcAwPIxDxf+o4TmVodC23E/hiUsR/BYOXjAb9kTmdC09qC2wxKVfuTILu2QmreXyeFc
 ZYuIMZVeiRJxMQXkhiPwmyv4mbmoH2pc=
X-Gm-Gg: AR+sD119Pv7Ixvc7G6mMb0FyAKptouCN7hnox1Y3czaaKKq/dadDKKh61rdX5W4gzjc
 dlKl1sarTtMFd21c8od/4wzxX2lrivAtMMD4xFCd3kbCE3yJeGig5rrj04tUDGHlY95C5hevNga
 FxJbiE5LyzXAUvUx45RkP8aW2ZonJazbsU+INZ4+hhGksmdC2UfQl2/rRt8failfgIQEGqcan8R
 m36B6TZFbve5CLt108QVcYxIgWva76UM+hPBGtjlsPhzmk/3BhHLkDaRZWHmWzwIun6Lk2N/Gph
 Fu/OKdINPq+9L9WGa0qJ0NQTU9Ktqq/HemQBuAEd+Aj2/g==
X-Received: by 2002:a05:690c:6b03:b0:7ba:f0d0:5e9b with SMTP id
 00721157ae682-849f4692ca7mr107963927b3.2.1787661184163; Tue, 25 Aug 2026
 05:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <ed82f56171bbab8b150d3512412cda12e7e09a7d.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <ed82f56171bbab8b150d3512412cda12e7e09a7d.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:32:52 +0200
X-Gm-Features: AcwNN1Xtzi2WJl1KccSUfPCnVd1JKytTLunfgDKRxF-zeJjSJm8murTNkgUrOck
Message-ID: <CAEWPSH7AcRb4uAnhmcL+kk3mQrgqYsQAYR=JQjJdkFGVK4qfHw@mail.gmail.com>
Subject: Re: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
 ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jiaxing,

One small thing I noticed while applying the series for the
RK3588 re-run: the cover letter says this patch carries a git
note naming the base and the one prerequisite, but the posted
mail has no Notes section - perhaps format-patch ran without
--notes. Mentioning it only because Rob's bot asked on v8 for
the dependency to be recorded in the patch itself, and it would
be a pity to collect the same remark again on v10.

Regards,
Igor

On Mon, Aug 24, 2026 at 1:10=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
> already describes, but it wires them up differently: two extra CBUF
> clocks, two power domains per core, and a single reset instead of two.
> It also has no NPU SRAM supply.
>
> Widen the property ranges to cover both, then pin each SoC back to its
> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
> required for rockchip,rk3588-rknn-core only.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a490..3b611b64c 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yam=
l
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yam=
l
> @@ -21,6 +21,7 @@ properties:
>
>    compatible:
>      enum:
> +      - rockchip,rk3576-rknn-core
>        - rockchip,rk3588-rknn-core
>
>    reg:
> @@ -33,14 +34,18 @@ properties:
>        - const: core # Main NPU core processing unit registers
>
>    clocks:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 6
>
>    clock-names:
> +    minItems: 4
>      items:
>        - const: aclk
>        - const: hclk
>        - const: npu
>        - const: pclk
> +      - const: aclk_cbuf
> +      - const: hclk_cbuf
>
>    interrupts:
>      maxItems: 1
> @@ -51,12 +56,15 @@ properties:
>    npu-supply: true
>
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>
>    resets:
> +    minItems: 1
>      maxItems: 2
>
>    reset-names:
> +    minItems: 1
>      items:
>        - const: srst_a
>        - const: srst_h
> @@ -75,7 +83,40 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-rknn-core
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +        power-domains:
> +          maxItems: 1
> +        resets:
> +          minItems: 2
> +        reset-names:
> +          minItems: 2
> +      required:
> +        - sram-supply
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          minItems: 6
> +        power-domains:
> +          minItems: 2
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          maxItems: 1
> +        sram-supply: false
>
>  additionalProperties: false
>
> --
> 2.43.0
>
