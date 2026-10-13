Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463E6CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9553210F9A1;
	Tue, 13 Oct 2026 20:35:25 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8254410F9A3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:35:19 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c2e36c3478aso48127766b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791923718; x=1792528518;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LW10asy9KSTOiiqztGh47B9kXPqdbR7tUZT+37TKLvs=;
 b=Ap73XWEk/mp2F3phxR0xFg5n5fKFFnzV/wnAcQ+KJ8d8VufbmK+yX78UvSuC7Dyuqo
 zLmObDqm9ofMyFSSTnMFtVVIdTItmA+3Q++E2GupOKBCCN1TKYgW92IzlLiUcCVaIwvL
 EKegoYtsT3zeGSOGP24UjslFwtDOubY/rzmcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791923718; x=1792528518;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LW10asy9KSTOiiqztGh47B9kXPqdbR7tUZT+37TKLvs=;
 b=AOy9NJc3jaSIm/z4Tem0do04W93C/LamTokd95hgJBSH7WMx3+Q02n1ImetSi84EFE
 dQjpi+aujg+OcYGnyOZhhG5WlgkrTb/nQe1H/GAt1i0woSYmZB5F64ADfndqpOntSdbm
 TQQoAcb0bjEpS5yYlaLSfDZ1vAm4bE1PHR4hGaPsw3qd+TVMzZ+zhg9BL9UT/EmVZwo6
 MPqLop23+wJNtA4hHXKXog5R/pH4oRzEkGrT6ZWkv2zlfd2jK+LeD6vfzqCgkVyjSHPz
 F7AEhbQbXOnB3IwKivf6q9hJ2NqwGJ4MjGBtAkf328ovVz87WXaoIu6PFudoA6Lbi2jx
 134Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhtDaOmw2xqQIMatjKxq5t+hRiLN6+FdrzCenVDw7xdfGyM8OQMxgOPq8e0C6pCSfTfR8Ru+ZEe3c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJY2A5M+0aPMhWYJstr91MtVxl+2bUgc/rsEsHmtu4oQPj1E53Q
 7CPF066G5Gn6BAsliSzkPj9B41HgauQ3/BSPpFXygsPM313A19pjVqQQMPZZ4wJJMr/SP8Zy95S
 uuPWTQw==
X-Gm-Gg: AYBFou0+Lb1jIt2Gnhb+Q65gqEiMyQcVnNoY7zgZ8gYbXP6VHKIWNWamVhCQWlRZUJl
 iQ1GGRCGBSE3FT6UOtQb2v6wYGXjERBJoFD4DDbkP2/TmCksUiNyWVisq/fOT2cmUKpUuHk9xSp
 5+SnzNDt5H+4zC18O7JDDQ756B4TZeCP5EYYtiGaMmzd7dV+Q8q3fcIaCzVxodgduFYipoqMiTW
 qua+42a9XUm5Y8Mw3z1QGNowIS3L5/U33qXMsDQISprix4nT0eQeu7EMmhqqy035UpxS850380C
 gNQ2cEbpZVQRs2itict6rhyMo3864iX5G5yELyJ8wbDq1LN+0nQUlOvxLnc4e+gLzxi4uwTYua5
 MmBjJC0S/q/gO+W9BcFSNjV5MmkFWQQwlHdFr0cYTpqbD6N5dvYiU85fVDlMAZp9wr5kryyfb2W
 zdY02aivhyCrckcFVpxF5is1XeWk52GK2IQtRqluaEq26qcKBT38LCTuFvRQKV3Oa0Uer90n99L
 y0AihyGniSFg+kvOLIga+rlMmwR42dg292yXus=
X-Received: by 2002:a17:907:94d0:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c31aa0ac6efmr1447358566b.38.1791923717780; 
 Tue, 13 Oct 2026 13:35:17 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3bc20sm635523166b.22.2026.10.13.13.35.15
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:35:16 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so3101683f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:35:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzSBIBtnLL79D7uHQPWZgQBwS5H5PMeI7LmM89cUJ6H2FVUmXZHbWwOUphM8Fkgs4sBRbjigmQFpvc=@lists.freedesktop.org
X-Received: by 2002:a5d:4b4c:0:b0:48b:f92:1f67 with SMTP id
 ffacd0b85a97d-48dbaae6d3cmr18389338f8f.21.1791923713788; Tue, 13 Oct 2026
 13:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-1-7188e7ea7a15@fairphone.com>
In-Reply-To: <20261012-book2go-v1-1-7188e7ea7a15@fairphone.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Oct 2026 13:35:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVAnohGm8kmaLpfchk_MxCiUB8EcyyWBxZqtnc+9YPcg@mail.gmail.com>
X-Gm-Features: AclHuK_Kdnq_Nm7orMZLL2zoW1RgGH3OpgePi2fH32LmSKFmFT8VrWVBo8fW_FI
Message-ID: <CAD=FV=WVAnohGm8kmaLpfchk_MxCiUB8EcyyWBxZqtnc+9YPcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panel-edp: Add AUO B140HAN04.0 panel entry
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, Jasper Korten <jja2000@gmail.com>
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

Hi,

On Mon, Oct 12, 2026 at 11:11=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.c=
om> wrote:
>
> From: Jasper Korten <jja2000@gmail.com>
>
> Add an entry for the B140HAN04.0 eDP panel. It is found on the Samsung
> Galaxy Book2 Go.
>
> $ edid-decode /sys/class/drm/card0-eDP-1/edid
>
> 00 ff ff ff ff ff ff 00 06 af a9 65 00 00 00 00
> 28 20 01 04 a5 1f 11 78 02 9b 85 92 56 59 90 29
> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 14 37 80 b8 70 38 24 40 10 10
> 3e 00 35 ae 10 00 00 18 00 00 00 0f 00 00 00 00
> 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 42 31 34 30 48 41 4e 30 34 2e 30 20 0a 00 ed
>
> Signed-off-by: Jasper Korten <jja2000@gmail.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 2b455369ed70..73cdc2d37ab7 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1986,6 +1986,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116X=
AN06.3"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140H=
AK02.7"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x643d, &delay_200_500_e50, "B140H=
AN06.4"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x65a9, &delay_200_500_e50, "B140H=
AN04.0"),

I'd assume you don't have a datasheet here and that the timings are a
bit of a guess. It's nice if you put that in the commit message, but I
won't block it. Ideally you could reply here and let me know if you
referred to a datasheet or just made a guess about the timings so if
the question ever comes up later we can find the conversation based on
the Link: tag...

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/3] drm/panel-edp: Add AUO B140HAN04.0 panel entry
      commit: 9125232bc2a5020710db1eadd21973757f740648
