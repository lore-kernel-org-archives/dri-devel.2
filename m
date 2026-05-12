Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7069CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 18:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2697810EBCF;
	Tue, 12 May 2026 18:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eFmlmYCA";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFB710EBCF
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 18:15:38 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso10858227eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778609738; x=1779214538; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TqTMATn1TJBwDzhvgfdwIn2iY4blCTuTwL1WgCFtdYE=;
 b=eFmlmYCA0U1BZ8Tm9o4uPEX8BoM1Szt1KfvoRzmmNYdyqMvS8eKUTZ4CjT7GrCDeVY
 3sM7n+TrnDElLGOohEHIFPnEwmoLhJ6ZfSVbuUDgJLpkdXjsVKxGDMO6AywRZv7su+l3
 TAu+tNJu4yMwAZ8/orkcd+TlKBNBH5r2iNSZL/NbyJOXCocFhlitBSC5iZd1SLOLjB6E
 pVaFULq9e7rRpVScXd5ivtj3b6ElFuB29mnS1l8RTVfskiSSPgJ3lN/X6KMaqIqVsrXg
 SctFE6PkQ7Ryx60/Qnk92apPT9DvXJktNauRIu3V0cQJcljH8wrRboRi+z70ThE7TQqr
 MZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778609738; x=1779214538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqTMATn1TJBwDzhvgfdwIn2iY4blCTuTwL1WgCFtdYE=;
 b=f+K6ujJDGOo8wvl8BTV5jgBoSnFNNzHVdAo7Wbm2X891GmTGSOtG5c+u/bixUKB6Eb
 aPWNLLPE6cCDm/tEO0wzO8HSoeIonO9kaQJhtn9dy8+9Tk5P8s768O/+H4kFQzSMoSTc
 vpeavUxBAbpv4SGk5k0uIpc35zTCO84lrRsDKkEMNCmq6Ai0GNkNpzmztSm01aBSF3KM
 eeJXGYLpkIvzN26rj7HkuwNJoDeWVGRw2Dg1Wtqa/kzhANKsb1e5eclnQayfqdmS9gyE
 wK3BWUo0L7rd+SSdaO8CeSV5L6qrmdxh7zDBBLwoOPGfnH9aRQ18aqbnTUKwpiyVqGPp
 M+6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XwDUw+urRUTT8/xxqTQwhV59jBTCuC+PKsqR4BNLcse7i1FWAtAGaF8QdBOGaZ8koYom7o+/wuFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6C75JKYXJYMxM46wvyI37xO7Ug4N9snjUJMbCfBnggHLfyJzV
 OnLtoT/C1U5VaoYwY7Vy2uDf2EHAK03Umh81szl8AR+Zr39NrwxHjbsL
X-Gm-Gg: Acq92OGB+vw43fMTnxUrtvvojB+XWXr1FSSbeVPl0NLydT+LhxleAjuNDbcGD9g37so
 VMK2TWAwGUGESsvMh+ebEAo32e+f+9Ck2ba/OZZHSC5pmyt3vppptFn21r6Qhgwa6cilqyBImQc
 3Py8Bx9Bc8gVeAg44gKGDB6H6fQ5j/rGpZPXHagWlOQZeqXH/akq9Kwf1NMEDDEdAsP9ovV2T3F
 lLl5u00Np9x9G8M1vv3fBh/EVun/uVOCHl8B5PfesEpP4cMcm5olO9hNMI1lcRG2ENtly4GH/i9
 rvekI8Vu5ct8zjSrOhh1IfQdrb3C3vqYtv5L25IW6QzfUnsY69Ej08NBj3Katq3kiOSw2Aw0oih
 g7dTbklNtRMF5U7OVc3uA0gFg+6oefI09p3Kkc/QLbq82ObWiqORUj3VQrO+Mg4xFpyAWFGHiTI
 aiLdaXexQmfXF6chTsvKVEsCvqdpTH5MUo/Snh+2n6mANjjrW/nIkwQUCpfk7Yj7xR
X-Received: by 2002:a05:7301:22a9:b0:2f5:6dfc:cb6d with SMTP id
 5a478bee46e88-301187bab75mr130655eec.11.1778609737694; 
 Tue, 12 May 2026 11:15:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:84ac:d22c:b037:1a93])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88847502fsm22940594eec.14.2026.05.12.11.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:15:37 -0700 (PDT)
Date: Tue, 12 May 2026 11:15:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>, 
 Andy Shevchenko <andy@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 brgl@kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, platform-driver-x86@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 3/7] driver core: platform: provide
 platform_device_add_software_node()
Message-ID: <agNrB3BeIgFlZimz@google.com>
References: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
 <20260512-swnode-remove-on-dev-unreg-v5-3-0035eff63812@oss.qualcomm.com>
 <DIGUBLZXZXPJ.8CX0K5EL6255@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIGUBLZXZXPJ.8CX0K5EL6255@kernel.org>
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

On Tue, May 12, 2026 at 06:31:44PM +0200, Danilo Krummrich wrote:
> On Tue May 12, 2026 at 1:59 PM CEST, Bartosz Golaszewski wrote:
> > +int platform_device_add_software_node(struct platform_device *pdev,
> > +				      const struct software_node *swnode)
> > +{
> > +	return device_add_software_node(&pdev->dev, swnode);
> 
> I think this should be device_create_managed_software_node(), see also [1].

The main issue is that we do not know if the software node is registered
or not when platform device is registered, and are trying to use
heuristic to figure it out and decide if we need to clean it up or not.

You need a new variant of device_add_software_node()
(device_set_software_node ?) that would bump up reference of already
registered software nodes but if node is not registered yet created it
as managed.

Thanks.

-- 
Dmitry
