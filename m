Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A512AC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F1C10F263;
	Fri, 28 Aug 2026 06:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kroah.com header.i=@kroah.com header.b="GdFz8X0M";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7Iih7PK";
	dkim-atps=neutral
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC4710F263
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:33:27 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 6C4A11D00084;
 Fri, 28 Aug 2026 02:33:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 28 Aug 2026 02:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1787898806; x=1787985206; bh=1TqSf34J+R
 Q18DtwXjAHDC4SqrdULRczMIhIFP3i3+w=; b=GdFz8X0MY9cmkbgl6QfrCC4VS9
 rKjVtsXJZ5epg+LMH5OWXNnzGGDf9p8G3HHL1DICmeJlKKWXyKl5ykoLdcAGjVYV
 3a/yls5UFkiua6wX3w0ZpP+7d/wYFNBSGtKliTAncauLT38SMnJjURESqQn/ujGg
 myVXTrumdHNSvbbIWT5Fg9Ul7Yi71Bi1ZLV/c/UoyzaalywZSbOQMsRdv/8xkxEc
 6CPXqew827WiJLF7GbcFazCq/Pl8t2WCYrtFDjKC7clG+XUpaVzcwmqYWTOBNaFd
 fxCz3PQlxvtbo+yliZ0uKs4AG8b4itBxZ2zXLFwzzbzVHt8uHvGCFkyMYI/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1787898806; x=1787985206; bh=1TqSf34J+RQ18DtwXjAHDC4SqrdULRczMIh
 IFP3i3+w=; b=g7Iih7PK8tvCvBEUj6QnvP9IL1R7+DBhfVryzTU78H5OseZohJK
 bHVaoNP5dwP2w4B4THVhvDfvb3VMc+1px98laaNbtkc2ESng6SgsKRDm4Swp82Eu
 RZkwcZ0FZWQb4OnnVToJiMDR/qiP7FEtHw26JDNd/4TcuvzbRzqOOnS/WpuEGteh
 1a/dZGqvI+9Q3oZW9mn1OlU+H+KSGoBs1MMjQV1gAMZ7qBNbkf9T6hvKvXl6eCB/
 hiFgJN/Jq6j9IqjQWL1vnTobpRd5yTf9Ah+1pTVdgmLvw2cIlAzqB6bdJJkvZ3Y2
 B62OQhiJr/D0CD0rhvDVsGZSV8MJddOkKbw==
X-ME-Sender: <xms:tiuRakW_FBxdJVM1A3o5vL9pFn30_smYpYxIjMwpuA2tnQWG9unlXQ>
 <xme:tiuRahUKcl_OHmJv2RpOolxjtNcRnZUYiJonZCxPeBaNoMFli932Edp0EjivZxC1s
 YB1eJunMmUZqiIGdCUgCb4NooVyhB2zHpR8Z-puk4vfsWib6zI>
X-ME-Received: <xmr:tiuRanFImOQiRxMHqXzDUNuqnXNO99xqFKnHHc7LcLTUmHHZRw6GqhHW8D1ZqO6yaQQyEQayKwDWHME3aRj5509MPpSqWGNTHiKK4MTS4Mw>
X-ME-Proxy-Cause: dmFkZTEZ6B3DcKaFrRdVvEemO7U2LvZ0RsCSSwPpTRLaLJLYhJAIQ0Nn1nUfkVjiVzd3oa
 UnCZAHz9G9A7+WApVEQKKvIk+nVQ24CYPVQXoxzQLDx4JwV/s8wRHc/jEMVAciVKAoRHhF
 8OMHM/9MqeL06uV7TVE/j+sdXUag5LQ2Sq2W5VEvRBYTvdOz5XDDl0vQAIfPwCWiopyp6R
 sujEFnNDD9E+e886nZMvGUJGnavx58HAj0qlQYZb7M67J708f3YfuKHVC4050T8Fob1oqz
 poaFxfh6k6bSlK+hlrig2pru0zAfU/LqTeKY6xUVpoY85bvu8A3wwGLp/kPG2uMgCDT7n0
 9QOqorTXt8e0O0djv3Jp6jvyUpTdyUyFtDoauKXeZ4xuIRgfvoHr8dN8rzOumPYlk6TJRG
 oHafcBjOkeTl41J+ZbLCBdizg1K3KuYT9Fuv9IK1JUgf3wTfrjUabcjX93yRzmKeRidyhc
 m74fOYK54J2eePZK5ybZg4/yKHloO7jQ4ZlvCBakCrJQKxxeAIrw9Cp7kRFod+0KVqWEXv
 FLwiduJaHaa02Ftdk/1RJpjWZlfWVw80va9YGxSSI4n2c+SQtgrdtQOFETewaLrmClMe7s
 nLGaui8b660VrVMIiYLJe8CWykNnOZ21xqDiJ7khzQtZidl4UVMOPX7QbZ2w
X-ME-Proxy: <xmx:tiuRalv1Mk5zkil4m4mpNPJZ80jlRSeR5B89-1jAYKbBpsB2be89YQ>
 <xmx:tiuRaib5vMmGGq01R9U0iuQW_FXg4T0ZQJY6yOEkIOF9ymzGFG6Vjw>
 <xmx:tiuRatXvTFTjvisSHnS73ypHe7tsb8J6tuDL-7hHy6wtl0HhhwDbxA>
 <xmx:tiuRakKFPehDAo0Mf2Sg7PJGKfejKVr5QzZwPmaPXp5MzJzgHMb70w>
 <xmx:tiuRav8A06Lpw-jyF9lqVLlzlSjJPFvY-eFk-Kyp5h2GUcin661mxm2O>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 02:33:25 -0400 (EDT)
Date: Fri, 28 Aug 2026 08:33:24 +0200
From: Greg KH <greg@kroah.com>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Sidong Yang <sidong.yang@furiosa.ai>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] accel/rocket: Validate BO handle counts on job
 submission
Message-ID: <2026082816-regular-doze-e442@gregkh>
References: <20260828061916.20405-1-Naixumogu@whut.edu.cn>
 <20260828061916.20405-2-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828061916.20405-2-Naixumogu@whut.edu.cn>
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

On Fri, Aug 28, 2026 at 02:19:14PM +0800, MoGGuU wrote:
> The input and output BO handle counts are __u32, while GEM lookup and
> reservation helpers take int counts. A count above INT_MAX cannot be
> represented safely by the GEM lookup helper.
> 
> Reject each count above INT_MAX before looking up the BOs.
> 
> rocket_job_push() already uses check_add_overflow() for the combined count,
> but stores the result in u32, so it only detects unsigned wraparound. Store
> the result in int so sums above INT_MAX are rejected before the count is
> passed to the reservation helpers.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>

Real name please.

thanks,

greg k-h
