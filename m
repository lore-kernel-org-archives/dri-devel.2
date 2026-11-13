Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D08606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8418710E663;
	Fri, 13 Nov 2026 00:58:59 +0000 (UTC)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A0210E663
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:58:53 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so459939d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794531532; x=1795136332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kPewN3XXLhv6qEd6YPb2El+caas6WhoqgqzECAeuxVI=;
 b=gY2ZA7lOXKIjzQmm2MHmVYLIbKQhkp/v6YHLP+E+mKXQygkcTa7I3wKL6PXsSsU/zf
 iqsgT6V1VX0iRgHa5QptTgqjiOo8yT7f0yOLyYdvnvLEFO5yKG/HvS/faqQ/wmUyoLzS
 OFXIY3fV+eWMZANGZYLIOFiSDa8/T6h6RqpVjXJFglOI+tAu9+wQfQr6KPMakw1NUV7H
 Tn+EG7lz0+A2zeOD28Tf74KbYjtkWglH4Blhkpye4rd4TSHtspd+zrCGb7WVnLSvSe97
 gDel7RMS9+YpaTSn9rZlO73A3z9rQ/cCOZ89roIeomwr+CHRfI6s0mDtkMfLC3zIKq2s
 hgfQ==
X-Gm-Message-State: APuU4Z9aku6DwqspPiSF0jITfYdASoprgvT1sSfzQiZAHzm6aRVbDr6I
 kdJOgf1DRoO3fM/nZNA1losbzoq68I/x2gxXqWujt0E4mkfvR46U9eYk
X-Gm-Gg: AYBFou2QRpwRJeBDhe5/rMBzBAmAWeXxjJEvKSTA7JwgVMCqZ5L1uBi8J+d/lSFNgF+
 WGkUOgABY/+JvdVs9v6ct+IxVt9xemkuBx0GqUuQBS5+scqxvTttHU0mk/ILKG3OIP23cJ7Uh1h
 wpMGfmRErdx3oT0X2ir70Elgx36H/6T5+X4G5zt79oAncWira2mAqmaiCvyRSK/EsculQVmDCtQ
 oeM/KB36iIR3NgPYhTqg0JnaOO53MTx4vdMREbraAG4CsVQPUnYvri1GT7JMApviZw2xoc/uW/+
 TO81DiUQfDnU73vD0GRzx/V3Pzr+blQNbc3dRi3/wcXrjVU7D73k2mSSW0UebW8LRtO1Ok65T6g
 EIbffWXwfFTca6PaAQ+2LyoNYx4nTrGyHppJngUw78QQeuCiwwh+nOZQM/IzZYRlz282i8R1dvM
 KW/mRAO1qBbgTzuTom2ZGCTG1llGSo9ihiRNfzjSbKi0oQMjddytvWugHpXcvF9Rhpxp04YjBOd
 oDfxK2V+FrlDBZE8bTVrWhwWn9DViRb0C4BptTK0eRQ4xcpIzZ/x6Cuirb+t35VMFBM0F5AvFoY
 P8LrnBIHQEBe6buvhdzcKUHR4LMQpwp78ct1f156mInKVNel3GVebtzl7dM3kFVMUsmlGP+QcOX
 dBiRI5oPLZFeYKElqNlDQIKwllGZOZPRA
X-Received: by 2002:a05:690e:4087:b0:67c:2a61:ac2b with SMTP id
 956f58d0204a3-67d895e448amr666447d50.34.1794531532269; 
 Thu, 12 Nov 2026 16:58:52 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67d8a55b08fsm749470d50.7.2026.11.12.16.58.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 16:58:51 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: operatingsystemsdepression@gmail.com
Cc: dri-devel@lists.freedesktop.org, patrik.r.jakobsson@gmail.com,
 tzimmermann@suse.de, Joseph Telaak <joseph@telaak.dev>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
Date: Thu, 12 Nov 2026 19:58:46 -0500
Message-ID: <20261113005846.67202-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAFGNeajWk0aAnTHyHFmp+gEYJi_RMcLkw0s6yenBeZgT6uF9gg@mail.gmail.com>
References: <CAFGNeajWk0aAnTHyHFmp+gEYJi_RMcLkw0s6yenBeZgT6uF9gg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 9:22 PM Gabriel Gama wrote:
> About the SGX544MP2, I was thinking about making a separate DRM driver for
> Clover Trail+, since it's quite different from Poulsbo, but I'll take a
> look at powervr_sgx too

powervr_sgx is render-only, so it doesn't depend on the display side:
on the CE5300 it pairs with simpledrm, and on Cedarview with gma500.
On Clover Trail+ that would mean a display driver plus an SGX544 entry
in powervr_sgx's core table, not a second GPU driver. The part the
driver doesn't have yet is a multi-core (MP) GPU, and I'd be glad to
work on that with you.

The notes on adding a core are here:
https://github.com/The1TrueJoe/powervr_sgx/tree/main/docs/porting

> I'd be happy to compare notes, especially about PDS and MMU stuff

Same here.

> I've been following your project for a while now, back when mine was
> still mostly documentation

Thanks, that's good to hear.

Joseph
