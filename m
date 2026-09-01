Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857D3C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85B010EE01;
	Tue,  1 Sep 2026 17:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WH4jmE2y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFF710EE01
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788284278; x=1819820278; h=date:from:cc:subject:message-id;
 bh=snQtyGINWTMHDjz7mQPWM35JlsHEnNaeS5CVb+BJXRs=;
 b=WH4jmE2ylr+su7vEhcxJf/EuqZKP7liBSWG0CDlzq+9W96jc1Sezcd/g
 NIwTI4dcTQJru0elSmFWpfmMVKajcUuZQrXMeH2nFDHt9rAIPcwIwAyp6
 dniRbUrU/Nj5Ad68lPQTxxr5uUKqy6p8LmF8GCGDhRbmZmxKRpZKvnVZZ
 XLYWxXJL3y+y7DnVyf9bTtoHoVJmyORSoKN4GlyTBUw0sDFJxdRBEdcY7
 bvlGg3GYLI3Jvuaq1FtdAVvd020Cguuyv81izrH6Rnz4B4/EakiJGlHUO
 rsGxLgGWVWUd3twPMxO3D5N1v3t4gToArsAxx87bEB3alm17UATG3/QB8 A==;
X-CSE-ConnectionGUID: swInLyfPQoq0QALHhF1Psw==
X-CSE-MsgGUID: mrEQBq/2TaS7qipv+BwQ1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88603743"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="88603743"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 10:37:58 -0700
X-CSE-ConnectionGUID: z9cdM4d1QnWQfzCmfwb9hQ==
X-CSE-MsgGUID: WY6e8s7WReKHJ56NmY6ilg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="307390137"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 01 Sep 2026 10:37:56 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x1SQj-000000001EX-2Pc3;
 Tue, 01 Sep 2026 17:37:53 +0000
Date: Wed, 02 Sep 2026 01:36:58 +0800
From: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [drm-misc:drm-misc-next 1/4] sound/soc/ti/omap-hdmi.c:408:4:
 error: 'struct hdmi_audio_data' has no member named 'card'
Message-ID: <202609020151.f1wEmFNW-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
head:   0116f19db5931348c937eafa1f76a9a19bf82c81
commit: 1ae7fe832c2d3ecc75815eed037a07290586b6be [1/4] Merge drm/drm-next into drm-misc-next
config: sh-randconfig-r062-20260901 (https://download.01.org/0day-ci/archive/20260902/202609020151.f1wEmFNW-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609020151.f1wEmFNW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609020151.f1wEmFNW-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/ti/omap-hdmi.c: In function 'omap_hdmi_audio_probe':
>> sound/soc/ti/omap-hdmi.c:408:4: error: 'struct hdmi_audio_data' has no member named 'card'
     408 |  ad->card = card;
         |    ^~


vim +408 sound/soc/ti/omap-hdmi.c

50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  333  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  334  static int omap_hdmi_audio_probe(struct platform_device *pdev)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  335  {
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  336  	struct omap_hdmi_audio_pdata *ha = pdev->dev.platform_data;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  337  	struct device *dev = &pdev->dev;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  338  	struct hdmi_audio_data *ad;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  339  	struct snd_soc_dai_driver *dai_drv;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  340  	struct snd_soc_card *card;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  341  	struct snd_soc_dai_link_component *compnent;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  342  	int ret;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  343  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  344  	if (!ha) {
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  345  		dev_err(dev, "No platform data\n");
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  346  		return -EINVAL;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  347  	}
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  348  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  349  	ad = devm_kzalloc(dev, sizeof(*ad), GFP_KERNEL);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  350  	if (!ad)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  351  		return -ENOMEM;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  352  	ad->dssdev = ha->dev;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  353  	ad->ops = ha->ops;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  354  	ad->dma_data.addr = ha->audio_dma_addr;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  355  	ad->dma_data.filter_data = "audio_tx";
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  356  	ad->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  357  	mutex_init(&ad->current_stream_lock);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  358  
d20fa5a06d7bddb sound/soc/omap/omap-hdmi-audio.c Laurent Pinchart  2017-08-11  359  	switch (ha->version) {
d20fa5a06d7bddb sound/soc/omap/omap-hdmi-audio.c Laurent Pinchart  2017-08-11  360  	case 4:
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  361  		dai_drv = &omap4_hdmi_dai;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  362  		break;
d20fa5a06d7bddb sound/soc/omap/omap-hdmi-audio.c Laurent Pinchart  2017-08-11  363  	case 5:
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  364  		dai_drv = &omap5_hdmi_dai;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  365  		break;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  366  	default:
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  367  		return -EINVAL;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  368  	}
642a722d3116fbd sound/soc/omap/omap-hdmi-audio.c Kuninori Morimoto 2018-09-07  369  	ret = devm_snd_soc_register_component(ad->dssdev, &omap_hdmi_component,
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  370  					 dai_drv, 1);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  371  	if (ret)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  372  		return ret;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  373  
b1a549c6be09243 sound/soc/omap/omap-hdmi-audio.c Peter Ujfalusi    2018-05-07  374  	ret = sdma_pcm_platform_register(ad->dssdev, "audio_tx", NULL);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  375  	if (ret)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  376  		return ret;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  377  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  378  	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
fb5ab7296a2bea1 sound/soc/omap/omap-hdmi-audio.c Kiran Padwal      2015-02-12  379  	if (!card)
fb5ab7296a2bea1 sound/soc/omap/omap-hdmi-audio.c Kiran Padwal      2015-02-12  380  		return -ENOMEM;
fb5ab7296a2bea1 sound/soc/omap/omap-hdmi-audio.c Kiran Padwal      2015-02-12  381  
524d3f126362b60 sound/soc/ti/omap-hdmi.c         Primoz Fiser      2024-06-10  382  	card->name = "HDMI";
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  383  	card->owner = THIS_MODULE;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  384  	card->dai_link =
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  385  		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
18c94a043d6a466 sound/soc/omap/omap-hdmi-audio.c Julia Lawall      2015-12-20  386  	if (!card->dai_link)
18c94a043d6a466 sound/soc/omap/omap-hdmi-audio.c Julia Lawall      2015-12-20  387  		return -ENOMEM;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  388  
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  389  	compnent = devm_kzalloc(dev, 2 * sizeof(*compnent), GFP_KERNEL);
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  390  	if (!compnent)
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  391  		return -ENOMEM;
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  392  	card->dai_link->cpus		= &compnent[0];
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  393  	card->dai_link->num_cpus	= 1;
1af529320d56e99 sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2023-09-11  394  	card->dai_link->codecs		= &snd_soc_dummy_dlc;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  395  	card->dai_link->num_codecs	= 1;
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  396  	card->dai_link->platforms	= &compnent[1];
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  397  	card->dai_link->num_platforms	= 1;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  398  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  399  	card->dai_link->name = card->name;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  400  	card->dai_link->stream_name = card->name;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  401  	card->dai_link->cpus->dai_name = dev_name(ad->dssdev);
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  402  	card->dai_link->platforms->name = dev_name(ad->dssdev);
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  403  	card->dai_link->init = hdmi_audio_dai_init;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  404  	card->num_links = 1;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  405  	card->dev = dev;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  406  
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  407  	atomic_set(&ad->jack_state, -1);
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19 @408  	ad->card = card;
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  409  
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  410  	snd_soc_card_set_drvdata(card, ad);
98e9645a35993f8 sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2024-01-11  411  	ret = devm_snd_soc_register_card(dev, card);
492a53506ab27d5 sound/soc/ti/omap-hdmi.c         bui duc phuc      2026-07-16  412  	if (ret)
492a53506ab27d5 sound/soc/ti/omap-hdmi.c         bui duc phuc      2026-07-16  413  		return dev_err_probe(dev, ret, "snd_soc_register_card() failed\n");
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  414  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  415  	dev_set_drvdata(dev, ad);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  416  
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  417  	ha->audio_hpd = hdmi_audio_hpd;
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  418  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  419  	return 0;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  420  }
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  421  

:::::: The code at line 408 was first introduced by commit
:::::: 699e5975e2a53820d8248e4e69e3645d8fa3eff8 drm/omap: Report HDMI hotplug events to the ASoC HDMI codec

:::::: TO: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
:::::: CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
