Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAB606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbJ6IA4a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E9610F32E;
	Tue, 27 Oct 2026 09:32:02 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D5210EDBB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:20:01 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-704597ef1d8so1217483eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793010001; cv=none;
 d=google.com; s=arc-20260327;
 b=B1V2UW4N1yLVu9oy11TKNR+2l1+psJl9E4D6QWp20KKrNbI9QWGSrwOYTpBz1SQmyf
 LYc0gtbFCItH7LnlZQ8owzn8qn+NxQGDKH0kc2T6aGcQdeRH1WliL+xhXcQ/jV8mQw8t
 lLFms+LoaVj2/S1hW0GIde5F7L2/qtNy4kvKdXhKzcHxzCHXRR7Z96qxT7oQrAvH+5fI
 EBHUPMh0Q20E/uSvHA7aVI/pOVvY9K7f24AgMnk6RZY/QOvWnNvi1Yl4cQoJ5Ud+s01U
 zjoanihVS/2xJGaMO6YUbg1FMf5PUOCdUPjTRSGUU/kz7iMffe+vOjrWkpfdx7BioZm5
 ThOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fbJOoGCOLIQzP8MPpKpAlj4vz5dI1YiHPW1SWmOARzw=;
 fh=ET+yM1bxX2kyB+Zi2lTQ3uFO7vvTFfM4EFOdPflNdSA=;
 b=IwlIbXPpav9xleuVCuXxl8SmZmkxdsqm3Ulk3MlCna76vmiGqJ9I3iVGijzJ6JeaRZ
 7nVjUMhr8dujOe+b+ZfsVHW/yZg22MPCxc4HfAIwhykpkuqnEtjl75I0ERRhtV7cHb0O
 7hUWE3IGTnCsi5Vrwiwf+k3eJksGfGhJ3PA2VLpN1rIfSrfSExrWdLj/pHEiXIx7Fvkx
 xTPK+X0+Kdzm7eGscvExu0fp0pqg9h3vyxJhu3OirkLqxWy2nA/H1oMeRMPve64u0K5P
 srA/r7Jjk8ScqS4umA9X8dTmncbVQjvqDA6y3OSykqYZhmP566MAeikOw7PiQreXecLH
 lBEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793010001; x=1793614801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fbJOoGCOLIQzP8MPpKpAlj4vz5dI1YiHPW1SWmOARzw=;
 b=TbJ6IA4aQPFQyHdXN3AeDn3vr8xRS+BRpIiFtL4Hbf1K5IBSbmTyoCOnl+fbW7TOko
 K+k+kbUtiseZQMfFWIM6DeCy2HzzRdbCGLcvyhplddgyereI/p9bWKKq2OR3poJI0CX2
 aQGKzlqqZQSfKeGx89kuFfxHCQT9Ru/yk6gryPkhhscNGWDueVKQ0FiBbH/TGYj8ReG6
 Rs73zrNgJlo2qRovzgMJg70vKuho6ra3nZCM10YON8RygFKWL/LvWKZ3Cpy8YN6r0QoH
 oZnvcvbXOdPyT81zAcEYw4Bwx+Z0B/m+K80rXSl2l7Kfoz1/7m1Hf6QXi4X8J6FM0X4K
 kiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793010001; x=1793614801;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fbJOoGCOLIQzP8MPpKpAlj4vz5dI1YiHPW1SWmOARzw=;
 b=xZ01SGblZs0n1e93CgZByC+1u7dSoGkEHOXGoCXcU4DfEY1qVk/URCi6AiruChAV04
 dyvyZkyLsbQIFqDloptdelv0zZ8QYtpF+mVJTd+3HaLZxR/txS7rEEV8mbHDdDj9vMeI
 VnQq/3rka5vdPOKi9njocqAw2q8N01JWya8haKaH5iWbhMKeXRK4mXlpj4LnJzXwuZ/R
 fOH5fhVfbTGYyctpvh6WTdgl+phQkbEoh4aXQnMgatsGKCCa9clOMESyPrV95F+OhAk7
 qGNM9S30NB4qc4S4dD//lJWbsSy/hgxexFCQotkI7k7HQtmSkHi/JTjWinHZovHZLBGW
 edWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByx5oVGKmzSQNlUqbxjyndDaP58Ystru/A1PEVvijQX0wZE3y9Bk+6bWH5wNWU+yVg02TNgge+SOSc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPNVb/dUgdu+2FXtltIu5JmQEZ474N1zyJxopc3YAviDt47JYs
 1It/r5I5095a3PBtIOCAeQniSolrIPVw4an5917aDs2qThehLKQOIzcs+E73lzBgTQ1EnzJMLxo
 ou8VefIsVc8AxfZghUH5cwlkcxkClq5Q=
X-Gm-Gg: AYBFou0BWASYSAq8Avoj07n+h2ZmvQswNdVqkLHvaF4xO3wCIWOQOeyiCzhZevp2rJL
 mPKsmd2nUvG3FFkcNfGqs/o/PcMobgj3QlbtMGGlzvRNWxYCPDVLOfeJJE8OEKDnuQIgC5X6Cbo
 QwORy6CXpoAOUS03YfZ/H8k4fNZL6ENoavxSMFyspsQ5f5rnVXyqUfIi/cJgccHy+CzQLEqtl++
 lsgp7Qi5wgfuYJLaQY1DTztuYZeQL6QnxtxpjkjwyDsJRLgKJ+KKdXMRY8bcMWsoEspdxSwkPqv
 St7uw58LGv4+SuGrPpGUhmp3JosrOUBi1u3CZYm0PwL9VT5CvKJ0To9sIywa0LzbmDYohdYZFDQ
 HttXgJv9aP1aX+Rdmrdg7fndXHQN11k/lfcl2Q4ilHXzb8BMjOVrolMNq6PollA19ckJISm8=
X-Received: by 2002:a05:6820:1391:b0:6dd:25a3:94dd with SMTP id
 006d021491bc7-70ba0e5707fmr3311431eaf.41.1793010000474; Mon, 26 Oct 2026
 03:20:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
 <at8h0ignZd8srvBi@ashevche-desk.local>
In-Reply-To: <at8h0ignZd8srvBi@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:49:49 +0530
X-Gm-Features: AclHuK_R5q_T7vpDB0YLNH0Ux2MdD6xxwDnqBRfktX82gSMvkXVTnMhZtHYzD28
Message-ID: <CAGLmz9+y5fXCf2-XFrFHfqAws5eODP4pSSro96R8vmt_aUQGMg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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

On Mon, Oct 26, 2026 at 3:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> You must learn to provide a changelog!
> What has been changed? Why (whose request was that)?

Hi Andy,

Thanks for clarifying. I have sent the v3 patch and
added what you requested.

Thanks and regards,
Himanshu Bakshi
