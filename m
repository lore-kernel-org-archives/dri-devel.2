Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B75CCA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3972F10E4C0;
	Wed,  7 Oct 2026 01:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b2DWymbQ";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9B010E4C0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:40:24 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1812261f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337223; x=1791942023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HDM/IhuAZ+mZ2yb1biv87C3WVL00TVKLh/5oVRCg27Q=;
 b=b2DWymbQCmGjFX9gS/DpFQD+LJAwalWeBcOe0lJc65+tSj1uJqRTbjrdx3dFVp/AVG
 AAIZrji6lw0nM6RpVCeJGzem7ogrutI6t5SdmKfbkYmZzDJ18rTpqTstjkD1AWxa2mvh
 Fm4dHNZuHUTzPvdJBUCRZ5mHLf0Vt5VEBNibTM6b6RElDZxs+/k1nRwNaL3AyA7ETN3g
 AJI6gulyRA6lj9ejGAlLK8mE3Cwithj/mh8A+gaDA15WgHK3xsyT3jtXMd+OBvQZl2rj
 iFg8iaC1m0GJkGo2V5oYepgbkbFbUDTL9j/kxbu7f5cMl0I1NLdyAxwdtjsXXLLYQVm5
 TMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337223; x=1791942023;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HDM/IhuAZ+mZ2yb1biv87C3WVL00TVKLh/5oVRCg27Q=;
 b=ij18SvJ8QbZd/a5zZsFRD6RL0x70zk4wyKHsccHLJbvrV09inncT0Ea/IPxpwuoVo+
 mXoVbVRCfQoUIkJWfbBpWA99Y32h08jVM589x/vVgz+vV6UemABH7hW2KPYsJMOPjl94
 R3RoysNu5Eh7FBr0OpPqUFTtV4ipMXAtQIAUK70Hjo7LBA6GFFpHFs6KtJ95oKF2GkE3
 NKygfPabPk0DgY2L4HTDWa16E99X2bsNTjg9C80C5+S+PAa0KehGwzrb5loXY+WlXk/S
 BV9nWXbQq2B9qWXrOpNo8d91spMCCuctCBWJulfdJ0JeaauiItZsNYe+CHIM678aTsNM
 EfQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZwZQ0bZ34lBraw7ePEhSf0eYtB3um/AEj7HGRu3SEycLYo+GjpdWo/s1D0pd7xnHt20SDroH/EAU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8MFHxl/eo98tzVDkEostkIX6UnXo9h2hsW54BEGbHt2T1f9TV
 71VJ8fDxsSIw0yIMaAuioEHFSz/LyfX3a3SNwQV3FRSxkqvI/WkrMl/N
X-Gm-Gg: AYBFou1dxBMulS9FHolkd5XaAs1lVud4X6YNGhdyvyc1yPrKz71GHhNGnFLtoty8Yyr
 p1Px3ZXEmqlo8rsTZ6G3XzyVGQQblR8pO/e2PS8ZDD0IHAViUT5FlPidgdEtQebE/pfegtgW+7k
 IeV2PwYBdi7BSOgGttL/ZKgA1iIKT3fwK9IJYm5VZStReKW1dpXJ0j5v8H4hvsTPKxE72kMMayC
 LfKi7XLEmCicpyMKgAlkFHXG+PisJ9IA59BYhEE3qfqfDkpqo+Lh5frv3DNEEGVbViPgMKsys/A
 k67sNXOTbHV/mqWAmxOLCRl/m/Xg2SxNnoWf0O7UbAH5JWpwMsxWH/e6QNdtrHe/fZKth29md46
 Bc6Bg6c1K4szKh5CmHFVPhJyE3P7cR+L1ysIfTLnjZ0s5I4Ss/XcV1Pb8M0xwkNmX8qlDLkJ0fZ
 am/OmQVWO4wJChC9/TCVm6i5YJHK9ozEF7s6VXxSXNFW/FzQhRTnE4R1QWUraIHosu67mxfg0UK
 Bybi/xVN8zaWDwRjEV/e2QWSJ5dfA1YkTbZvNB8joXVOzSqVxVSGRLeaZvrTk0GQs+AIo51zwoi
 L0fmUJRgz2wGz+duvkch5XUn2XNPsg7eOjKy2yniT2kdhje+
X-Received: by 2002:a5d:4b10:0:b0:488:8546:d0b2 with SMTP id
 ffacd0b85a97d-48c7289605amr1226256f8f.51.1791337222906; 
 Tue, 06 Oct 2026 18:40:22 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c7202fa0bsm2238873f8f.3.2026.10.06.18.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 18:40:22 -0700 (PDT)
Message-ID: <38719270-2ee9-477b-aa31-b4f90bcba020@gmail.com>
Date: Wed, 7 Oct 2026 02:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/13] Add dmabuf read/write via io_uring
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336002.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/7/26 02:31, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.

Apologies for a messed up submission, please ignore. I'm going to
send v9.

-- 
Pavel Begunkov

