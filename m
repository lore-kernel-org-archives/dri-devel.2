Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AFB1090222
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5265210EA0D;
	Thu, 19 Mar 2026 12:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZmdI0wFi";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A64410EA0E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:56:13 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-64e87a81639so1082053d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 05:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773924972; cv=none;
 d=google.com; s=arc-20240605;
 b=lMIGXMjnAcHMTJC5f2Z08OMdiK8A0BNwIEmCwNyXEp9Zf9Mr24IT5GLu43I4Q6lZIz
 O80gsODfcWopTg83TdWBMrG1n/8tUAmVZxA0PJVgYYUpMYUA6TPVUlVVD1AMv7uMxNSy
 RnhLqcgwYw8/ipj4Hh0asINEjlde3Pq1et0y/bEuV9yMCFopy11L0K9WYZfLCAu5pPB1
 rYXlzfX2mRgur3Hq3kzij8EFk3Vd7tqkKB9dl6Oe+3rhF2SYAmiS6UNrSBn847eAalT1
 Z0bhUlQCF5ObwFIvLqkzmldwGdmk3ZFd5qTdbl3WTPT+G1V41XZsnHlfbOEhuUEXiOUY
 wUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=SZi4Re3SXucsFhka21KttHxmT/G+LcLxY2K8OzCxBOE=;
 fh=ukS/bQLBgXbuMYeRAIbssq2wV6uiVV6Y9KFI5Il++k4=;
 b=GJRJP+Q5wl/U+inA8dkmgUiffo4F3XpDIE6uqcIcBXb8qAZYq/2gHtGL0cvZHhGM8c
 OeeMkedmaHOI5qoXhVr6PJALybL/Rs6TYbRPKVuMcZ5MlbjKofyKHIMr4iUMOvZ70eOS
 H4LbxaQgImqH59xbFJRyto0bOicdwKZIcxju4KQaXzyquNMa4rq6UTOhGqhcv+VFFmnY
 fiz5qHnnL7+hq6jxw6QXs0s4PWAghb8Gj5cz64c0e4H2a/h5oGS3udty7dW1MbGBzn8i
 wsSXjQoqy9CjbHbYGQcy+0lqvrhZiVvGl4ZArRIytIm5qO1wQwAYjGlxscbBM9BK35uG
 szBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773924972; x=1774529772; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SZi4Re3SXucsFhka21KttHxmT/G+LcLxY2K8OzCxBOE=;
 b=ZmdI0wFiFs9lDkzO1g2KXQHwVzCfr69mUp+p+WGh4IWLAB3a9JuPIfZwy/l+kPz+Lo
 UTLJn7sGqTXAoRL0JEggs5+uBJWMhOuFIDhuz0jc/DZMSS1ij4pNGETiLwCSSM1LQIvK
 2v+nPK0DmKPyfzHnzOuKVP1uPPGzts6DD1RvcOyKCnS2dTPKKVWdMXpur1owpIcRtG95
 B+wG0Tyd/oBiIPc2aDTbphisowtb59n0m3rZRiVwq5gSuUI53YLkVFb0K+2w29vOsmA2
 liMJwMEhcZQ+og3v7DU6QB8y9aJujI6HQSP+pPrL5OfrIETNL40l82O/4/WNlS9ZDxeY
 EaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773924972; x=1774529772;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SZi4Re3SXucsFhka21KttHxmT/G+LcLxY2K8OzCxBOE=;
 b=XMLo3p5KQYIin2FzZ1RGDAuTS4FzU2ajtw953VlwV0QF5/4VLYEsul1NyGRrfSTFSo
 +cgwwPJqHYLEQCmFcbBUz9QFWlDYGqNgw8txqpRGM52Ayr4L2bW7/jAZmLdEun0KmYK3
 SIY4rIZyuXb/zdaL1ESy3VKiaBZaIwdUHXRVR/dWOygs9zlCa9u2m4/IywXpCCU3uQCF
 5XAqE469GO7Ds7IfFXgGnVmkavZF0139y1Gv/WnI0dJg2fhxflwIOgGrAmgXk5Gw4rsp
 7COEiZ6uJoxeg6nAWBY2oyLKw+ZwnismriuE1XTJi3/dZPPb6fW7HGFaZM472CITQe4r
 yH6g==
X-Gm-Message-State: AOJu0YwkMHvyqg2tuUheKUGRNuR7eUdMl9w31VOtkH3NsfF2JtkHOd7J
 BL690x8bEHwE/QgP1xAc68iQ/nyUQpWCkPLLMdfqRMm7zZ2iDKNkD9h1WGrSMn7qBtaAbUR91zz
 8ylIYTMbwHWKGLwoBNO65PT657SXxWSyTJt3G
X-Gm-Gg: ATEYQzwMUJjjUov0NX13WdaibWR5GzljbHYRI58lgMwv53kmbzu1dlFj7y3ARQojunZ
 gZFhe0SUEHxuWYLEETIcieXQ1cV3c9u5ZhNty/DKtO5uYT/4FFo/A9R/FzuYRue4VMcULJtidxv
 UviUgEpyD23ysQ7x9RK5NpfUBYtO9DveD32wW1Ta/wXu2is2EU9qskkx44AK+hzUAmwLojgazIW
 Z4u0tA5w++PqyTF63WcTv/1nNRYEySvUyDdX0ITUHUmd9khBEV9E0SuJj+Z3u2m3zIpfXlCBlg3
 fqCJ
X-Received: by 2002:a53:e686:0:b0:64c:aa3d:f3c7 with SMTP id
 956f58d0204a3-64e91327c19mr5768881d50.19.1773924971974; Thu, 19 Mar 2026
 05:56:11 -0700 (PDT)
MIME-Version: 1.0
From: jim.cromie@gmail.com
Date: Thu, 19 Mar 2026 06:55:46 -0600
X-Gm-Features: AaiRm52qoFBAmxpgdOPG89IPCDPd7_u4eriymZSKfvfoggmKQ88eqi7xSgw-Yfk
Message-ID: <CAJfuBxwWHTFeq9t9GG7kxoTXVwxaJ2tPfOEtmZ5LS9FZ5jUjxA@mail.gmail.com>
Subject: IGT pinned at very old SHA ?
To: dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

jimc@frodo:~/projects/lx/igt-gpu-tools.git$ git log --oneline
129d5b10baaadea1d6cd6377341c4cb42e7ee6fd..origin/master | wc
   1130    8256   74979

given the magnitude, this must be an error ?
