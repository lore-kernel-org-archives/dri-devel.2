Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4D606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d5QC/qGG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E375F10E4EA;
	Sat, 24 Oct 2026 22:59:06 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A469710E038
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:52:35 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-4932b13c4ccso926474fac.3
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 06:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792849955; cv=none;
 d=google.com; s=arc-20260327;
 b=V1E3FoyU2vB3S2cFLHkEjwjWy9b2mirgX3tjQM82nkJ6HZ5hcY2KPaxmdK3sn/2kQ2
 lco5CC0QIiEc5BCYsXKt6t569oBbf1DaKyyd86PnG1pY4b2/bBNZsEqYhE8ol+Wg7FRR
 nvMCpKMeXqOVnsuJZzERExL0c2cijypYU8bPnG/W+gHQE/drJ+7gctXZFvzIaPysTiPr
 7sz3xA9RYYp2oCNNiidMTnpQr1ow3Tf9Gp+UWUGSLGa68TGICM2lQs2qJWoP/REfQ5xo
 5By5fANnxBJxXBcCHALtjhFEr2nbHoWUTJ5gDyLZB4WCVRLbfroCjU9NAnMRqhUOFfA8
 Oy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gWV/iUd8ZKTmxGqyjxZCrroXnRxOPVL3yFtv21UdG4A=;
 fh=KDGtIIfDoRXBVv5CnVD0GhC+WCgJfGEBDDYHxyHuNLE=;
 b=qt+mAO+ZK/hTXjE5WAnPXnHwgqlYKYnARb0zt4iXP+305xLKjeTq6+5xHJzPMsr5bM
 s+Nz/D+w6LGJaMlNUCqhW3WZF82rCYV1hDYbVyEBlDPf4vhZy4184gZrmLLvaW4YdJsO
 Yzj1h728x3+eAGlybgtv97Tp3pGjOcbP1VAW5SshkQz84qfF32hqgj5b6X4bXzGuduRe
 hJ5gZzTGhCbsNbERQdlwr1mxNFS+zxKD79GNBxnBsN291tSZXU1gBLhkSQYALMqZ7ocR
 u03oEeNdy36RCJKYeOlqrzjdpjEWYDUm2ZIsL7oClCdGG/fqhuAg+vTdLdG2rptMNEuk
 +L5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792849955; x=1793454755; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gWV/iUd8ZKTmxGqyjxZCrroXnRxOPVL3yFtv21UdG4A=;
 b=d5QC/qGGeqfR9ZJixVzcgbBAGK3dXFtL3FAvu4IT09fK/ukWCejJ5OXNBBmZWVQecg
 pC/a+r6kqFa4mooSkiTrrEKnE9n9V+rG2eyLPzeFj0rm2xW9I5dgeFrle3U7Or7EJhEZ
 mhzab46jBOdEMIhO713fg4RjAoK7RYt3zpjxscdzxU8nLLxKC3FSmYJW1zL6MbmjqL1N
 Qkv+9YJPEkxojzDSaT/YIPiVqmUcX7cyU87siVjA7Nu9iag4NEafhx6hW38C201Lhv3y
 VaAfdQKO4zPqtGw9+KEybmXRb6mejKJWChApdKbQX9jp+7qoR3ImuX5DJwgOoU8yoohC
 Ci6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792849955; x=1793454755;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gWV/iUd8ZKTmxGqyjxZCrroXnRxOPVL3yFtv21UdG4A=;
 b=hBs9rFMsr+znQLcO/hes1SC3TmtT1badb6yl0+g6u44rm7clzPSnzIc+jlLmX1VT+u
 A/cN8njn3zhNJakOIA82o0THSUpSM3PU6Q2If/ZqizikcZzZkUlfO7n3UyvB5KA9Eix+
 9AlujmKWR8iOe8vkp7G/z0TweE2u4Raw6AJ3L80CjHChMzBytvQ4ryuTTHgsJdSL1jnq
 9lT+1lAxAsMxZKC1kNW51zeUtP1b9+cSnRvkSlvnnjOXwQewReoQ4Q07haoXOvhPEJ79
 ZF7fohq0VzficCZ0vxgHaOzKzP49u7JQUF+qno5koCpzoBIJi2t97/09lA9gGpniaVnD
 6fGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdVahEGXOkJUkDQpjYyNJZUm4Qc4djf22B11v8XEKVAm57DCK/HXRiotxGmQ9RLN6bwjuELXvRikg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLk2DsJySqm4u5hyNBYNLgmkfESe5PFjbLuImssaF2M+GjwTLov
 wF/O7595wlg9XnjqtxJ8DBcMKiN7cDgrYfFkG8fHuORuXgwL7cdRWfC6VJqPTwYvgBxACBtZLPA
 OUkUPyUafzXUThTOLjVVqRgopDSUHwVDFuCpaJR0=
X-Gm-Gg: AYBFou0EDxycKnrVTdAA85c8F0FLwFQJTOlc3+kXqQO9XzHeiKxwk6ipmbXMfLyVKhJ
 vaCUTIUeshaL37bVoHPGtxnyxgW0pxxCw8QkxVZNvMJtQ60EN4jXEU4XNrVocF/ni7PbrrTIrgD
 5F2YyDy8pzh481BBJ0lbfBPok40OhDizz5VOAi/gaxEc05hyw/LsDG0fSAVKwPrqrQBurck4D8b
 eEuePEFtj5EEzY3fbgvCDMaXl2dD6y0eSaTCyA1aU9hCzIuvz31MIGsutWqA0Hvq/Mr+f3jLMs0
 2tQPVIheBw/P+2pYyEuoe1aZy+vL42hyxtKNKlmCeJ87cS+a9y2hSpuxNfjeINwtYEHgbRVzsOP
 Zu/BNLJYRWeCNIIkzGtErldpbMMkvzMdgR9w=
X-Received: by 2002:a17:90b:3d8e:b0:3ac:7116:434a with SMTP id
 98e67ed59e1d1-3adea8993a1mr1856032a91.15.1792849598060; Sat, 24 Oct 2026
 06:46:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <e84774ae-b49d-4df5-923d-ae2cde480aaf@broadcom.com>
 <20261023090121.5031-1-fausten@ebizmis.com>
 <DMCM449DWDHV.1U5UYOS65HWUW@broadcom.com>
In-Reply-To: <DMCM449DWDHV.1U5UYOS65HWUW@broadcom.com>
From: Li Yunfeng <yunfeng.li.nb@gmail.com>
Date: Sat, 24 Oct 2026 21:46:25 +0800
X-Gm-Features: AclHuK_urc7K4uvYu0W4yOWciiC6ompk8CUiFOsTakNy-BJbCuY0E8_Rp8lJ80s
Message-ID: <CAO6tsQgWAn8LLJvYfY34Es43oNk=qrZBE4Do6xcHpYyivPJzDQ@mail.gmail.com>
Subject: Re: [PATCH v4] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
To: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org, 
 bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000006d9c95065e96531f"
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:00 +0000
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000006d9c95065e96531f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 7:37=E2=80=AFAM Maaz Mombasawala <
maaz.mombasawala@broadcom.com> <maaz.mombasawala@broadcom.com> wrote:

> Hi fausten,
>
> Sorry for not following up on this patch, I did not get time to do so.
> Will get back to it shortly.
>
> --
> Maaz Mombasawala <maaz.mombasawala@broadcom.com>
>
>
 Hi Maaz,
No worries, thanks for the update.

Thanks,
fausten

--0000000000006d9c95065e96531f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"box-sizing:border-box;color=
:rgb(36,41,46);white-space:pre;min-height:1lh;font-family:ui-monospace,SFMo=
no-Regular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier =
New&quot;,&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,&quot;=
PingFang SC&quot;,&quot;Noto Sans CJK SC&quot;,monospace;font-size:12px;let=
ter-spacing:0.35px"><br></div></div><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 24, 2026 at 7:3=
7=E2=80=AFAM Maaz Mombasawala &lt;<a href=3D"mailto:maaz.mombasawala@broadc=
om.com">maaz.mombasawala@broadcom.com</a>&gt; &lt;<a href=3D"mailto:maaz.mo=
mbasawala@broadcom.com">maaz.mombasawala@broadcom.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi fausten,<br>
<br>
Sorry for not following up on this patch, I did not get time to do so.<br>
Will get back to it shortly.<br>
<br>
-- <br>
Maaz Mombasawala &lt;<a href=3D"mailto:maaz.mombasawala@broadcom.com" targe=
t=3D"_blank">maaz.mombasawala@broadcom.com</a>&gt; <br>
<br></blockquote><div><br></div><div>=C2=A0<span style=3D"background-color:=
rgba(0,0,0,0);text-decoration-line:initial;color:rgb(36,41,46);font-family:=
ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quo=
t;,&quot;Courier New&quot;,&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Y=
aHei&quot;,&quot;PingFang SC&quot;,&quot;Noto Sans CJK SC&quot;,monospace;f=
ont-size:12px;letter-spacing:0.35px;white-space:pre">Hi Maaz,</span></div><=
div style=3D"box-sizing:border-box;color:rgb(36,41,46);white-space:pre;min-=
height:1lh;font-family:ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,&q=
uot;Liberation Mono&quot;,&quot;Courier New&quot;,&quot;Microsoft YaHei UI&=
quot;,&quot;Microsoft YaHei&quot;,&quot;PingFang SC&quot;,&quot;Noto Sans C=
JK SC&quot;,monospace;font-size:12px;letter-spacing:0.35px"><span style=3D"=
box-sizing:border-box;background-color:rgba(0,0,0,0);text-decoration:rgb(36=
,41,46)"></span></div><div style=3D"box-sizing:border-box;color:rgb(36,41,4=
6);white-space:pre;min-height:1lh;font-family:ui-monospace,SFMono-Regular,M=
enlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier New&quot;,&q=
uot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,&quot;PingFang SC&=
quot;,&quot;Noto Sans CJK SC&quot;,monospace;font-size:12px;letter-spacing:=
0.35px"><span style=3D"box-sizing:border-box;background-color:rgba(0,0,0,0)=
;text-decoration:rgb(36,41,46)">No worries, thanks for the update.</span></=
div><div style=3D"box-sizing:border-box;color:rgb(36,41,46);white-space:pre=
;min-height:1lh;font-family:ui-monospace,SFMono-Regular,Menlo,Monaco,Consol=
as,&quot;Liberation Mono&quot;,&quot;Courier New&quot;,&quot;Microsoft YaHe=
i UI&quot;,&quot;Microsoft YaHei&quot;,&quot;PingFang SC&quot;,&quot;Noto S=
ans CJK SC&quot;,monospace;font-size:12px;letter-spacing:0.35px"><span styl=
e=3D"box-sizing:border-box;background-color:rgba(0,0,0,0);text-decoration:r=
gb(36,41,46)"><br></span></div><div style=3D"box-sizing:border-box;color:rg=
b(36,41,46);white-space:pre;min-height:1lh;font-family:ui-monospace,SFMono-=
Regular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier New=
&quot;,&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,&quot;Pin=
gFang SC&quot;,&quot;Noto Sans CJK SC&quot;,monospace;font-size:12px;letter=
-spacing:0.35px"><span style=3D"box-sizing:border-box;background-color:rgba=
(0,0,0,0);text-decoration:rgb(36,41,46)">Thanks,</span></div><div style=3D"=
box-sizing:border-box;color:rgb(36,41,46);white-space:pre;min-height:1lh;fo=
nt-family:ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,&quot;Liberatio=
n Mono&quot;,&quot;Courier New&quot;,&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,&quot;PingFang SC&quot;,&quot;Noto Sans CJK SC&quot;,m=
onospace;font-size:12px;letter-spacing:0.35px"><span style=3D"box-sizing:bo=
rder-box;background-color:rgba(0,0,0,0);text-decoration:rgb(36,41,46)">faus=
ten</span></div></div></div>

--0000000000006d9c95065e96531f--
