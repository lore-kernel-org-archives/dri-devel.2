Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79902CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C321410E31F;
	Fri, 16 Oct 2026 14:28:25 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E94E10E10B
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 14:28:18 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-353804b591eso11276189eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792160898; x=1792765698;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CZxkiz+xTIZ/TNPEj8NCd1tJgQoYh2xpx5y74xAxmD4=;
 b=e0uK9JU5lFDteQfcRM8eVJanfsWPH6C8qAyB5Ac5CU5BR6YdIPDwVSNfiPcDuYln8P
 C2c6me+uzJZhcR0xUgqEKdjmR/TeTYmVf+seMCOFubgbIUYRk49fYaBqQjAp1P8TocLN
 OlmdZbvDKZgzcS2eJmNdc7kT32736p5fWMJPRD+VLK6OkIqLt5HbqYIyW6u7LK0SJJM+
 URLZ07AScRhf64a6WBNUXzqN8P1J7uv2Yi0IUEDQghs3RhWqZCQGfV6Eqja+ZjCJJ2TP
 II2Eep5oZycoJAaFynGCdjHg+Ss1C1+m6OfGkKFAnN1TLOh6e4yE5neydjyfhm3n/A2m
 fT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792160898; x=1792765698;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CZxkiz+xTIZ/TNPEj8NCd1tJgQoYh2xpx5y74xAxmD4=;
 b=HQHu58gQ8AdbEN3nmvAmaD/vNOsNi7EYoUhLvNiKA5O7i0EEJDizuSRxUDKwyOEbsM
 TBpYebgSEW2NzGYiaSSSpP41zhWO828e8dCo11LD4AurearlsEgBTAymOvPAI08wx+gN
 i+YIz+RIwhqS+q1Fi/7Z0b++0GFiYKMmBjgCLGzBPuBeBMsUY1tWxoL6mw6AZJtzxkLV
 V43MiCXcaXxZSj0SSDoTzH1CzTFAQ22HrspIGjmqgKzQmbenC+k5Ua7IO6BXmO4SIh9m
 AhHq7PStQrdbWZGVHTbHKAlko3zYwJ6kuO307KQwhVmuilQE2YGg5ywDMeyFPqAzYvgp
 1hnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjXIlvIfIn+uZGEGIGvHayVE+AKAh31jxI3pvGEL7cJOAkHaJvXqQ1Q9XPLhzDnsNvDqZkVHQ7ipk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJxV/EKe6pAhIV7fpkmqc0Du2KyVxT03Ncs7aNsVwdFigpxL3cD
 6VZ8YQ4AFmeiFjp9XD/p/gHlQjbSC2Xv5OfJY+tmlXDQhrvJe4BGy6mOixLXXyV7xB0=
X-Gm-Gg: AYBFou0/02XnmEfWn1rz16ddTCTrkjkOKHXx3EUL5hxyGcb/jw7iD+g9ALBedeyhoxJ
 rJ64a3UvTQXWLqNNLtRQask1TytUIvSz2iB0ayN0tI7IHDXgTmOZId6ySFEskL8Kztjnp61dJ6o
 EA9ZVTbKEQ1zLOrSLQTStvid309UPyR1oiTT1uHjPd87vNzDZnEOBlJIRXzQK/n60y3qPw9ot/Y
 FXx3+hzk6AswKQHakgr8MtpG2VbwqNfG5is7S7eUlZx0TnFKfVg39OgnxBlI6TpMMS3yOZ+wZU/
 d5Hzxy7rLlp/HcNkD8Gyk/YEuMBc9rZDOdrjOAeorMZb+LD48qrDLiHudIA1o5Hx44W0ihOc2Z3
 nc06g42SGgAYS8A/swmgfo//vfEskuzYQjLJy2W6iQYo0UiJ/zSBKvcl9DJvk8aquS0K3dH/B1V
 sPwu44OSThs794ui/AaqZXOdM5vTiI2m7PhRXYmoI5EnAqO8M4SJn+R/WsIUoU8KiPeoem4aKGG
 xGRlZ6RhzyDIlVxmRPOp6/DabI23laNhGDwfiYq+8nqV1qbAt9ZApeiIA==
X-Received: by 2002:a05:7301:180a:b0:35b:91da:7cb with SMTP id
 5a478bee46e88-35b91da1eb4mr17969593eec.35.1792160896140; 
 Fri, 16 Oct 2026 07:28:16 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081bafa7asm7150945eec.14.2026.10.16.07.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 07:28:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
In-Reply-To: <cover.1792144609.git.asml.silence@gmail.com>
References: <cover.1792144609.git.asml.silence@gmail.com>
Subject: Re: [PATCH v2 0/2] clean up dma-buf-io kerneldocs
Message-Id: <179216089525.2070939.12960580037397248054.b4-ty@b4>
Date: Fri, 16 Oct 2026 08:28:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Fri, 16 Oct 2026 10:58:29 +0100, Pavel Begunkov wrote:
> Add a kerneldoc for dma_buf_io_init_map() and clean up it overall.
> Targeting the Jens' branch where dma-buf-io sits. If preferred, it
> can all be squashed into
> 
> 0d3120db2cbe0a ("dma-buf: introduce initial file I/O infrastructure")
> 
> Pavel Begunkov (2):
>   dma-buf-io: fix typos in kernel docs
>   dma-buf-io: document dma_buf_io_init_map
> 
> [...]

Applied, thanks!

[1/2] dma-buf-io: fix typos in kernel docs
      commit: 44e75dbecb19579db9a070ac8d5f7b400297c1ec
[2/2] dma-buf-io: document dma_buf_io_init_map
      commit: aeef964d73dbfd7f477182bac934cdb4087d1724

Best regards,
-- 
Jens Axboe



